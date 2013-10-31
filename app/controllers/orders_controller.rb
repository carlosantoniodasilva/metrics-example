class OrdersController < ApplicationController
  before_action :set_open_order, only: [:edit, :update, :destroy]

  def index
    @orders = Order.includes(:customer, :items).order('id desc')
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order, notice: 'Pedido criado com sucesso'
    else
      render action: 'new'
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Pedido atualizado com sucesso'
    else
      render action: 'edit'
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'Pedido removido com sucesso'
  end

  private
    def set_open_order
      @order = Order.open.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:customer_id, :comments, :completed)
    end
end
