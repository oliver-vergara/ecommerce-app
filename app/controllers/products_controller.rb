class ProductsController < ApplicationController
  
  before_action :authenticate_admin!, except: [:index, :show, :search]


  def index
    if params[:sort] == "low_price"
      @products = Product.order(:price)
    elsif params[:sort] == "high_price"
      @products = Product.order(price: :desc)
    elsif params[:sort] == "discount_item"
      @products = Product.where("price<?",10)
    elsif params[:category]
      @products = Category.find_by(name: params[:category]).products
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

    @product = Product.new

  end

  def create
    @product = Product.new(name: params[:name], price: params[:price], description: params[:description], stock: params[:stock], supplier_id: params[:supplier][:supplier_id])
    if @product.save
      flash[:success] = "Product Added"
      redirect_to "/products/#{@product.id}"
    else
      render :new
    end
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
