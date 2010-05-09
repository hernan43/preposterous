module Preposterous
  class Post < Preposterous::Base
    attr_reader   :client, :attributes
  attr_accessor :site_id, :post_id, :title, :body, :autopost, :private, :date, :tags, :source, :sourceLink, :media

    def initialize(attributes={})
      @media = []
    end

    def attributes
      attrs = Hash[self.instance_variables.collect do |var| 
        key = var.to_s.gsub(/@/, '').to_sym        
        [key,instance_variable_get(var)]
        end
      ]
      # got to get rid of this one to keep Posterous from borking
      attrs.delete(:media)
      attrs
    end

    def is_new?
      post_id.nil?
    end

    def save
      if self.is_new?
        Preposterous::Base.client.newpost(attributes, *@media)
      else
        Preposterous::Base.client.updatepost(attributes, *@media)
      end
    end

  end
end
