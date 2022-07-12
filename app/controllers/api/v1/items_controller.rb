class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
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
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.new(item)
    else
      render status: 404
    end
  end

    private
    def item_params
      params.permit(:name, :description, :unit_price, :merchant_id)
    end
  end
