class AddProductId < ActiveRecord::Migration
  def change
    add_column :orders, :product_id, :integer
  end
end
