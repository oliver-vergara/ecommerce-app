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

  def update
    order = Order.find_by(id: params[:id])
    total_tax = 0
    total_subtotal = 0
    order.carted_products.each do |carted_product|
      total_tax += (carted_product.product.tax * carted_product.quantity)
      total_subtotal += (carted_product.product.price * carted_product.quantity)
  end
  total = total_tax + total_subtotal
  order.update(completed: true, tax: total_tax, subtotal: total_subtotal, total: total)
  redirect_to "/orders/#{order.id}"

end
