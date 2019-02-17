require 'rails_helper'

describe AddressesController, :vcr do
  let(:postcode) { '2076' }
  let(:street_name) { 'bundarra' }

  describe '#index' do
    context 'when all good' do
      before do
        get :index, params: { postcode: postcode, street_name: street_name }
      end

      it 'return 200' do
        expect(response).to have_http_status(200)
        expect(assigns(:addresses)).not_to be_empty
      end
    end
  end

  describe '#select' do
    let(:addresses) { ::Msats::Client.new.addresses.find_by(postcode: postcode, street_name: street_name ) }
    let(:address_id) { addresses.first.first }

    context 'when all good' do

      it 'return 200' do
        post :select, params: { address_id: address_id }
        expect(response).to have_http_status(302)
      end

      it 'create a new address record in database' do
        expect {
          post :select, params: { address_id: address_id }
        }.to change(Address, :count).by(1)
        expect(Address.last.address_id).to eq(address_id)
      end
    end

    context 'select existing address id' do
      let!(:address) { create(:address, address_id: address_id)}

      before do
        post :select, params: { address_id: address_id }
      end

      it 'return 400' do
        post :select, params: { address_id: address_id }
        expect(response).to have_http_status(400)
      end

      it 'does not create any new addresses' do
        expect(Address.count).to eq(1)
      end
    end
  end
end