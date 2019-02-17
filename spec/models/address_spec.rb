require 'rails_helper'

describe Address do

  describe 'validations' do
    it { is_expected.to validate_presence_of(:address_id) }
    it { is_expected.to validate_uniqueness_of(:address_id) }
  end
end
