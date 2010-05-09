module Preposterous
  class Post < Preposterous::Base
    attr_reader   :client, :attributes
    attr_accessor :site_id, :title, :body, :autopost, :private, :date, :tags, :source, :sourceLink, :media

    def initialize(attributes={})
      @files = []
    end

    def attributes
      Hash[self.instance_variables.collect do |var| 
        key = var.to_s.gsub(/@/, '').to_sym        
        [key,instance_variable_get(var)]
        end
      ]
    end

    def is_new?
      post_id.nil?
    end

    def save
      if self.is_new?
        Preposterous::Base.client.newpost(attributes, *@files)
      else
        Preposterous::Base.client.updatepost(attributes, *@files)
      end
    end

  end
end
