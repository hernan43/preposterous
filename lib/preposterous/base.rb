module Preposterous
  class Base
    extend Forwardable
    def_delegators :client, :get, :post
    
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def getsites
      response = perform_get("/api/getsites")
      # parse out sites? not sure how I want the API to look
      # for this. I have a couple of competing ideas...
      response["site"] if not response.nil?
    end

    def newpost(fields={}, *files)
      # create options hash
      options = generate_post_options(fields, *files)
      puts options
      response = perform_post("/api/newpost", options)
      # return post attrs
      response["post"] if not response.nil?
    end

    def updatepost(fields={}, *files)
      # create options hash
      options = generate_post_options(fields, *files)
      response = perform_post("/api/updatepost", options)
      # return post attrs
      response["post"] if not response.nil?
    end    

    # this is BROKEN
    # for some reason the XML will not parse
    # the CDATA fields are throwing off the parser(REXML)
    def readposts(fields={})
      response = perform_get("/api/readposts", :fields => fields)
      response["post"] if not response.nil?
    end    

    def newcomment(fields={})
      response = perform_post("/api/newcomment", :fields => fields)
      response["comment"] if not response.nil?
    end    

    def gettags
      response = perform_get("/api/gettags")
      response["tag"] if not response.nil?
    end    

    protected

    def generate_post_options(fields, *files)
      # create options hash
      options = {:headers => {}, :body => "", :fields => fields}
      options = options.merge(build_multipart_bodies(*files))
    end

    CRLF = "\r\n"
    def build_multipart_bodies(*files)
      # bug out early if there are no files
      return {} if files.length < 1
      
      boundary = Time.now.to_i.to_s(16)
      body = ""
      files.each do |file|
        esc_key = "media[]"
        body << "--#{boundary}#{CRLF}"
        if file.respond_to?(:read)
          body << "Content-Disposition: form-data; name=\"#{esc_key}\"; filename=\"#{File.basename(file.path)}\"#{CRLF}"
          body << "Content-Type: #{MIME::Types.type_for(file.path)[0].to_s}#{CRLF*2}"
          body << file.read
        else
          body << "Content-Disposition: form-data; name=\"#{esc_key}\"#{CRLF*2}#{file}"
        end
        body << CRLF
      end
      body << "--#{boundary}--#{CRLF*2}"
      {
        :body => body,
        :headers => {"Content-Type" => "multipart/form-data; boundary=#{boundary}"}
      }
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
