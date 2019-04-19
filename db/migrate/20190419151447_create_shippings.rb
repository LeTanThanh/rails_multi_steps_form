class CreateShippings < ActiveRecord::Migration[5.2]
  def change
    create_table :shippings do |t|
      t.string :receiver_name
      t.string :receiver_phone
      t.string :shipping_address
      t.datetime :shipping_day

      t.timestamps
    end
  end
end
