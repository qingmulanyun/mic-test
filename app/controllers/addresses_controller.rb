class AddressesController < ApplicationController

  def home
  end

  def index
    @addresses = ::Addresses::Finder.new(search_options).perform
    flash.now[:notice] = "#{search_options.to_s}"
    render 'home'
  end

  def select
    raise ResourceAlreadyExist.new(
        ErrorCode::ALREADY_EXISTS_CODE, ErrorCode::ALREADY_EXISTS_MSG % ["address"]) if address_in_db.present?
    address = ::Addresses::Selector.new(params[:address_id]).perform
    flash[:new_address] = "Insert new address: #{address.address_id} to database."
    redirect_to root_path
  end

  private

  def search_options
    params.permit(:postcode, :street_name)
  end

  def address_in_db
    @address_in_db ||= Address.find_by(address_id: params[:address_id])
  end
end
