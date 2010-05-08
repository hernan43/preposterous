module Preposterous
  class Base
    class ClientTypeNotSpecified  < StandardError; end

    # the following code is to allow for a 
    # active_record-y access to Posterous
    @@client = nil

    def self.client
      @@client    
    end

    def self.establish_client(config={})
      unless config.key?(:client_type) then raise ClientTypeNotSpecified, "You must specify an adapter type" end
      client = config[:client_type].initialize_from_hash(config)
      @@client = new(client)   
   end
  end
end
