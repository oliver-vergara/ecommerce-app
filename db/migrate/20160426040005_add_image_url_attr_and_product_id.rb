class AddImageUrlAttrAndProductId < ActiveRecord::Migration
  def change
    add_column :images, :image_url, :string
    add_column :images, :product_id, :integer
  end
end
