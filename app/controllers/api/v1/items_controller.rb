class Api::V1::ItemsController < ApplicationController

  def index
    render(json: ItemSerializer.new(Item.all), status: :ok)
  end

  def show
    item = Item.find(params[:id])
    render(json: ItemSerializer.new(item), status: :ok)
  end

  def create
    item = Item.create(item_params)
    if item.save
      render(json: ItemSerializer.new(item), status: 201)
    else
      render json: { :message => 'item not created'}, status: 400
    end
  end

  def update
   merchant = Merchant.find(params[:merchant_id]) if params[:merchant_id].present?
   render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end

  def destroy
    if Invoice.find(Item.find(params[:id]).invoice_items.pluck(:invoice_id)).present?
     Invoice.delete(invoices, item)
     item.destroy
   elsif Item.find(params[:id]).destroy
    end
  end

private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
