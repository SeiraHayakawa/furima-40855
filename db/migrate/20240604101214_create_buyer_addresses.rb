class CreateBuyerAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :buyer_addresses do |t|

      t.timestamps
    end
  end
end
