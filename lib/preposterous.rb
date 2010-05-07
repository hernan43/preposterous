require 'httparty'
require 'forwardable'
require 'cgi'
require 'mime/types'

module Preposterous
  
  # TODO: Add exceptions based on errors listed at: http://posterous.com/api/posting

  def self.make_friendly(response)
    Crack::XML.parse(response.body)["rsp"] if not response.nil?
  end

end

# bring in all of the files in the lib dir
directory = File.expand_path(File.dirname(__FILE__))
require File.join(directory, "preposterous", "base")
require File.join(directory, "preposterous", "httpauth")
require File.join(directory, "preposterous", "request")
