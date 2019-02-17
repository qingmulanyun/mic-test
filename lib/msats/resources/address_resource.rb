module Msats
  class AddressResource < Base

    def find(id)
      response = @client.get("mirns/#{id}").body
      response.present? ? JSON.parse(response, symbolize_names: true) : nil
    end

    def find_by(options)
      response = @client.get('mirn_address', options).body
      response.present? ? JSON.parse(response) : {}
    end
  end
end