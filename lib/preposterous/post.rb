module Preposterous
  class Post < Preposterous::Base
    attr_reader   :attributes
    attr_reader   :client
    attr_accessor :files

    def initialize(attributes={})
      @files = []
      @attributes = attributes
    end

    def [](key)
      @attributes[key.to_sym]
    end

    def []=(key, value)
      @attributes[key.to_sym] = value
    end

    def is_new?
      @attributes[:post_id].nil?
    end

    def save
      if self.is_new?
        Preposterous::Base.client.newpost(@attributes, *@files)
      else
        Preposterous::Base.client.updatepost(@attributes, *@files)
      end
    end

  end
end
