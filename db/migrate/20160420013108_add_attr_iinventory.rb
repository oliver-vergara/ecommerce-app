class AddAttrIinventory < ActiveRecord::Migration
  def change
    add_column :products, :stock, :boolean
  end
end
