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
    # going to pass this to the exception at some point... maybe
    msg = $2

    case code
      when 3001
        raise InvalidEmailOrPassword, msg
      when 3002
        raise InvalidSiteId, msg
      when 3003
        raise UserDoesNotHaveAccess, msg
      when 3004
        raise UnableToSave, msg
      when 3005
        raise UnableToFindObject, msg
      when 3006
        raise InvalidDate, msg
      when 3007
        raise InvalidPostId, msg
      when 3008
        raise CommentsDisabled, msg
      when 3009
        raise UnableToSaveComment, msg
      when 3010
        raise ApiRateLimitReached, msg
    end
  end

end

# bring in all of the files in the lib dir
directory = File.expand_path(File.dirname(__FILE__))
require File.join(directory, "preposterous", "base")
require File.join(directory, "preposterous", "httpauth")
require File.join(directory, "preposterous", "request")
