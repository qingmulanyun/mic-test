class AddAddress < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :address_id
      t.string :zipcode
      t.string :house_name_or_number
      t.string :street_name
      t.string :lot_or_unit
      t.string :summary
      t.timestamps
    end
  end
end
