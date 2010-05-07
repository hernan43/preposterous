require 'httparty'
require 'forwardable'
require 'hashie'
require 'cgi'
require 'mime/types'

module Preposterous

  def self.make_friendly(response)
    Crack::XML.parse(response.body)["rsp"] if not response.nil?
  end

end

# bring inall of the files in the lib dir
directory = File.expand_path(File.dirname(__FILE__))
require File.join(directory, "preposterous", "base")
require File.join(directory, "preposterous", "httpauth")
require File.join(directory, "preposterous", "request")
