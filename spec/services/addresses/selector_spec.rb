require 'rails_helper'

describe Addresses::Selector do
  let(:address_id) { Faker::Number.number(11) }
  let(:address_selector) { described_class.new(address_id) }
  let(:address_from_api) { JSON.parse('{"lot":null,"street_name":"BUNDARRA","street_type":"AVE","state":"NSW","postcode":"2076","property_name":null,"street_suffix":"N","suburb":"WAHROONGA","house_number":"44","street_number":"44","floor":null,"unit":null,"po_box":null}', symbolize_names: true) }

  describe '#perform' do
    context 'when all good' do
      it 'create a new address record' do
        allow_any_instance_of(described_class).to receive(:address).and_return(address_from_api)
        expect{ address_selector.perform }.to change(Address, :count).by(1)
      end
    end
  end
end
