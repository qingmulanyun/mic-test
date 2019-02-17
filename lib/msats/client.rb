require_relative 'resources/base'
require_relative 'resources/address_resource'

module Msats
  class Client

    def api_domain
      ENV['MSATS_DOMAIN']
    end

    def api_key
      ENV['MSATS_API_KEY']
    end

    # Create a new Faraday connection
    #
    # @return [Faraday::Connection]
    def connection
      Faraday.new(url: api_domain, params: {key: api_key})
    end

    # Make a HTTP GET request
    #
    # @param url [String] The path
    # @param parameters [Hash] Query params for request
    # @return [Faraday::Response]
    def get(url, parameters = {})
      connection.get(url, parameters)
    end


    # Available resources for {Client}
    #
    # @return [Hash]
    def self.resources
      {
          addresses: AddressResource,
      }
    end

    # Catch calls for resources
    #
    def method_missing(name, *args, &block)
      if self.class.resources.keys.include?(name)
        resources[name] ||= self.class.resources[name].new(self)
        resources[name]
      else
        super
      end
    end

    # Resources being currently used
    #
    # @return [Hash]
    def resources
      @resources ||= {}
    end

  end
end