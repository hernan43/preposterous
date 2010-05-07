module Preposterous
  class Request
    extend Forwardable
    def_delegators :client, :get, :post
  
    attr_reader :client, :method, :path, :options
    
    def self.get(client, path, options={})
      new(client, :get, path, options).perform
    end

    def self.post(client, path, options={})
      new(client, :post, path, options).perform
    end

    def initialize(client, method, path, options={})
      @client, @method, @path, @options = client, method, path, options
    end

    def uri
      @uri ||= begin
        uri = URI.parse(path)

        if options[:fields] && options[:fields] != {}
          uri.query = to_query(options[:fields])
        end

        uri.to_s
      end
    end

    def perform
      Preposterous.make_friendly(send("perform_#{method}"))
    end

    private

    def perform_get
      get(uri, options[:headers])
    end

    def perform_post
      post(uri, options[:post_body], options[:headers])
    end

    def to_query(options)
      options.inject([]) do |collection, opt|
        collection << "#{opt[0]}=#{opt[1]}"
        collection
      end * '&'
    end

  end
end

