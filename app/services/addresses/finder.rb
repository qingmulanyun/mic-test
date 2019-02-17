module Addresses
  class Finder
    attr_accessor :options

    def initialize(options)
      @options = options
    end

    def perform
      ::Msats::Client.new.addresses.find_by(options)
    end
  end
end