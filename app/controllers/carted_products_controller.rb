class CartedProductsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def create
    if current_user.orders.find_by(completed: false) 
      order = Order.find_by(completed: false)
    else
      order = Order.new(completed: false, user_id: current_user.id)
      order.save
    end

    

    carted_product = CartedProduct.new(order_id: order.id, product_id: params[:product_id], quantity: params[:quantity])
    carted_product.save

    redirect_to "/carted_products"   
  end

  def index
    order = Order.find_by(completed: false)
    @carted_products = order.carted_products

    
  end


  def destroy
    CartedProduct.find_by(id: params[:id]).destroy
    
    redirect_to "/carted_products"
  end
end
