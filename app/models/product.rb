class Product < ActiveRecord::Base
  belongs_to :supplier
  has_many :images

  
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
