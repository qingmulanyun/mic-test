class Address < ApplicationRecord

  validates :address_id, uniqueness: true, presence: true

  def house_name_or_number_json
    JSON.parse(house_name_or_number, symbolize_name: true)
  end

  def street_name_json
    JSON.parse(street_name, symbolize_names: true)
  end

  def lot_or_unit_json
    JSON.parse(lot_or_unit, symbolize_names: true)
  end

  def house_number
    house_name_or_number_json[:house_number]
  end

  def property_name
    house_name_or_number_json[:property_name]
  end

  def street_number
    house_name_or_number_json[:street_number]
  end

  def street_name_only
    street_name_json[:street_name]
  end

  def street_type
    street_name_json[:street_type]
  end

  def street_suffix
    street_name_json[:street_suffix]
  end

  def lot
    lot_or_unit_json[:lot]
  end

  def unit
    lot_or_unit_json[:unit]
  end

  def floor
    lot_or_unit_json[:floor]
  end

  def floor_type
    lot_or_unit_json[:floor_type]
  end
end
