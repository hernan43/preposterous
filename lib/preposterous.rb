require 'httparty'
require 'forwardable'

module Preposterous

  def self.make_friendly(response)
    Crack::XML.parse(response.body)[:rsp]
  end

end

# bring inall of the files in the lib dir
directory = File.expand_path(File.dirname(__FILE__))
require File.join(directory, "preposterous", "base")
require File.join(directory, "preposterous", "httpauth")
require File.join(directory, "preposterous", "request")

