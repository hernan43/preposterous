module Preposterous
  class Post < Hashie::Dash
   property :site_id
   property :media
   property :title
   property :body
   property :autopost
   property :private
   property :date
   property :tags
   property :source
   property :sourcelink
  end
end
