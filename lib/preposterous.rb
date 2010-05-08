require 'httparty'
require 'forwardable'
require 'cgi'
require 'mime/types'

module Preposterous
  
  class InvalidEmailOrPassword  < StandardError; end
  class InvalidSiteId           < StandardError; end
  class UserDoesNotHaveAccess   < StandardError; end
  class UnableToSave            < StandardError; end
  class UnableToFindObject      < StandardError; end
  class InvalidDate             < StandardError; end
  class InvalidPostId           < StandardError; end
  class CommentsDisabled        < StandardError; end
  class UnableToSaveComment     < StandardError; end
  class ApiRateLimitReached     < StandardError; end

  def self.make_friendly(response)
    raise_errors(response)
    Crack::XML.parse(response.body)["rsp"] if not response.nil?
  end

  def self.raise_errors(response)
    response.body =~ /code="(\d+)" msg="(.*)"/
    code = $1.to_i
    # going to pass this to the exception at some point
    msg = $2

    case code
      when 3001
        raise InvalidEmailOrPassword
      when 3002
        raise InvalidSiteId
      when 3003
        raise UserDoesNotHaveAccess
      when 3004
        raise UnableToSave
      when 3005
        raise UnableToFindObject
      when 3006
        raise InvalidDate
      when 3007
        raise InvalidPostId
      when 3008
        raise CommentsDisabled
      when 3009
        raise UnableToSaveComment
      when 3010
        raise ApiRateLimitReached
    end
  end

end

# bring in all of the files in the lib dir
directory = File.expand_path(File.dirname(__FILE__))
require File.join(directory, "preposterous", "base")
require File.join(directory, "preposterous", "httpauth")
require File.join(directory, "preposterous", "request")
