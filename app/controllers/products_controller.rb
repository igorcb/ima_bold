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
    if !params[:product_ids].nil?
      @remove_ids = params[:product_ids].split(",")
      #Product.where(id: [params[:product_ids]]).destroy_all
    end
    @products = Product.includes(:category)
  end 
  
  def ativate_selected
    if !params[:product_ids].nil?
      @update_ids = params[:product_ids].split(",") if !params[:product_ids].nil?
      Product.where(id: @update_ids).update_all(active: true)
    end
    @products = Product.includes(:category)
  end

  def deactivate_selected
    if !params[:product_ids].nil?
      @update_ids = params[:product_ids].split(",") if !params[:product_ids].nil?
      Product.where(id: @update_ids).update_all(active: false)
    end
    @products = Product.includes(:category)
  end

  def filter
    @products = Product.where(category_id: params[:select_category])
    respond_to do |format|
      format.html 
   end
  end

  def ativate_deactivate
    @product = Product.find(params[:id])
    @product.toggle(:active)
    @product.save
    flash[:notice] = @product.active ? "Products activated sucessfully.": "Products deactivated sucessfully."
    redirect_to products_path
  end

  private
    def product_params
    	params.require(:product).permit(:name, :active, :category_id)
    end

end
