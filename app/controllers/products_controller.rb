class ProductsController < ApplicationController
  

  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def new

  end

  def create
    new_product = Product.new(name: params[:name], price: params[:price], image: params[:image], description: params[:description])
    new_product.save
  end

end
