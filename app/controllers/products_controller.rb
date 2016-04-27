class ProductsController < ApplicationController
  

  def index
    sort = params[:sort]
    if sort == "low_price"
      @products = Product.order(:price)
    elsif sort == "high_price"
      @products = Product.order(price: :desc)
    elsif sort == "discount_item"
      @products = Product.where("price<?",10)
    else
      @products = Product.all
    end
  end

  def show
    if params[:id] == "random"
      @product = Product.all.sample
    else
      @product = Product.find_by(id: params[:id])
    end
  end

  def new

  end

  def create
    new_product = Product.new(name: params[:name], price: params[:price], description: params[:description], stock: params[:stock], supplier_id: params[:supplier][:supplier_id])
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
    @product.stock = params[:stock]
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

  def search
    search_term = params[:user_search]
    @products = Product.where("name LIKE ? OR description LIKE ?", "%#{search_term}%", "%#{search_term}%")
    render :index
  end

end
