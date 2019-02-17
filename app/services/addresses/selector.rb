module Addresses
  class Selector
    attr_accessor :address_id

    def initialize(address_id)
      @address_id = address_id
    end

    def perform
      create_address
    end

    private

    def create_address
      Address.transaction do
        Address.create!(
            address_id: address_id,
            zipcode: address[:postcode],
            house_name_or_number: house_name_or_number,
            street_name: street_name,
            lot_or_unit: lot_or_unit,
            summary: summary
        )
      end
    end

    def address
      @address ||= ::Msats::Client.new.addresses.find(address_id)
    end

    def house_name_or_number
      address.slice(:house_number, :property_name, :street_number).to_json
    end

    def street_name
      address.slice(:street_name, :street_type, :street_suffix).to_json
    end

    def lot_or_unit
      address.slice(:lot, :unit, :floor, :floor_type).to_json
    end

    def summary
      address.slice(:house_number, :property_name, :street_number,
                    :street_name, :street_type, :street_suffix, :postcode,
                    :lot, :unit, :floor, :floor_type).compact
          .merge(street_type: street_type_mapping[address[:street_type]]).values #fomat street_type for summary only
          .join(', ')
    end

    def street_type_mapping
      YAML.load_file("config/street_type.yml")['msats']
    end
  end
end