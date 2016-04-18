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
    flash[:success] = "Product Added"
    redirect_to "/products/#{new_product.id}"
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.name = params[:name]
    @product.price = params[:price]
    @product.image = params[:image]
    @product.description = params[:description]
    @product.save
    flash[:success] = "Product Updated"
    redirect_to "/products/#{@product.id}"
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    flash[:success] = "Product Removed"
    redirect_to "/products"

  end 

end
