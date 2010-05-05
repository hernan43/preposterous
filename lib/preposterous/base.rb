module Preposterous
  class Base
    extend Forwardable
    def_delegators :client, :get, :post
    
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def getsites
      perform_post("/api/getsites")
      # parse out sites? not sure how I want the API to look
      # for this. I have a couple of competing ideas...
    end

    def newpost
    end

    def updatepost
    end    

    def newcomment
    end    

    private

    def perform_get(path, options={})
      Preposterous::Request.get(self, path, options)
    end

    def perform_post(path, options={})
      Preposterous::Request.post(self, path, options)
    end

  end
end
