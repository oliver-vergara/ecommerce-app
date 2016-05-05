class Product < ActiveRecord::Base
  belongs_to :supplier
  has_many :images
  has_many :categorized_products
  has_many :categories, through: :categorized_products
  has_many :carted_products
  has_many :orders, through: :carted_products

  validates :name, :description, presence: true
  validates :price, presence: true, numericality: true
  validates :name, uniqueness: true

  
DISCOUNT_THRESHOLD = 10
SALES_TAX = 0.09
  def sale_message
    if price < DISCOUNT_THRESHOLD 
      return "Discount Item"
    else
      return "On Sale"
    end
  end

  def tax
    price * SALES_TAX
  end

  def total
    price + tax
  end

  

end
