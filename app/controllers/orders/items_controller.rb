class Orders::ItemsController < ApplicationController
  before_action :set_order
  before_action :set_order_item, only: [:edit, :update, :destroy]

  def new
    @item = @order.items.new
  end

  def edit
  end

  def create
    @item = @order.items.new(item_params)

    if @item.save
      redirect_to @order, notice: 'Item criado com sucesso.'
    else
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @order, notice: 'Item atualizado com sucesso.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to @order, notice: 'Item removido com sucesso.'
  end

  private
    def set_order
      @order = Order.open.find(params[:order_id])
    end

    def set_order_item
      @item = @order.items.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:product_id, :quantity)
    end
end
