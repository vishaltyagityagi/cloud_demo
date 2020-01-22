require 'net/http'
require 'uri'
module Operations
  class ServiceApiCall
    def initialize
      api_url = ENV["api_path"]
      uri = URI.parse(api_url)
      @response = JSON.parse Net::HTTP.get_response(uri).body
    end
  end
end



