class OrdersController < ApplicationController

  def create
    product = Product.find_by(id: params[:product_id])
    quantity = params[:quantity]

    subtotal = product.price * quantity.to_i
    tax = product.tax * quantity.to_i
    total = subtotal + tax

    new_order = Order.new(quantity: quantity, product_id: params[:product_id], user_id: current_user.id, subtotal: subtotal, tax: tax, total: total)
    new_order.save

    flash[:success] = 'Sold'
    redirect_to "/orders/#{new_order.id}"
    
  end

  def show
    @new_order = current_user.orders.find_by(id: params[:id])
    @product_name = @new_order.product.name
    @subtotal = @new_order.subtotal
    @tax = @new_order.tax
    @total = @new_order.total
    @email = @new_order.user.email
    @image_1 = @new_order.product.images.first.image_url
    @order_date = @new_order.created_at
    
    
  end
end
