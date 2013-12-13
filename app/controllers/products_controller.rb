class ProductsController < ApplicationController
  def index
  	@products = Product.includes(:category)
  end

  def show
  	@product = Product.find(params[:id])
  end

  def new
  	@product = Product.new
  end

  def edit
  	@product = Product.find(params[:id])
  end

  def create
  	@product = Product.new(product_params) 
    if @product.save
      flash[:notice] = "Product was sucessfully created."
      redirect_to products_path
    else
      render 'new'
    end  	
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:notice] = "Product was sucessfully update."
      redirect_to products_path
    else
      render 'edit'
    end
  end

  def destroy
  	Product.find(params[:id]).destroy
    flash[:success] = "Produto destroy sucessfully."
    redirect_to products_path
  end

  def destroy_selected
  	redirect_to products_path
  end 
  
  def ativate_selected
  	redirect_to products_path
  end

  def deactivate_selected
  	redirect_to products_path
  end

  private
    def product_params
    	params.require(:product).permit(:name, :active, :category_id)
    end

end
