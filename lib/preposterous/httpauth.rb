module Preposterous
  class HTTPAuth
    include HTTParty
    format :plain

    attr_reader :username, :password, :options

    class CredentialsError  < StandardError; end

    def initialize(username, password, options={})
      @username, @password = username, password
      @options = {:ssl => false}.merge(options)
      # posterous' API URL is http://posterous.com/api
      options[:api_endpoint] ||= "posterous.com"
      self.class.base_uri "http#{'s' if options[:ssl]}://#{options[:api_endpoint]}"
    end

    def self.initialize_from_hash(options={})
      unless options.key?(:username) and options.key?(:password) then raise CredentialsError, "You must specify both username and password" end
      new(options[:username], options[:password], options)
    end

    def get(uri, headers={})
      self.class.get(uri, :headers => headers, :basic_auth => basic_auth)
    end

    def post(uri, body={}, headers={})
      self.class.post(uri, :body => body, :headers => headers, :basic_auth => basic_auth)
    end

    private

    def basic_auth
      {:username => @username, :password => @password}
    end

  end
end

