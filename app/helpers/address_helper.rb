module AddressHelper
  def formatted_street_type(street_type)
    YAML.load_file("config/street_type.yml")['msats'][street_type]
  end
end