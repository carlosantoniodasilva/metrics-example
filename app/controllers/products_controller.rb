class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.where("name like '%#{params[:name]}%'").order(:name)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: 'Produto criado com sucesso.'
    else
      render action: 'new'
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Produto atualizado com sucesso.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Produto removido com sucesso.'
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :value, :active)
    end
end
