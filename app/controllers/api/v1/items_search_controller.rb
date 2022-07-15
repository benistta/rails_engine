class Api::V1::ItemsSearchController < ApplicationController

  def find_all
    items = Item.find_all(params[:name])
    render json: ItemSerializer.new(items)
  end

  def find
    if params[:name].present?
      item = Item.find_one(params[:name])
    elsif params[:min_price].present?
      item = Item.find_min_price(params[:min_price])
      if item
        render json: ItemSerializer.new(item)
      elsif item.nil? 
        render json: { data: { message: 'Error: Item Not Found' } }
      end
    elsif params[:max_price].present?
      item = Item.find_max_price(params[:max_price])
      if item
      render json: ItemSerializer.new(item)
      elsif item.nil?
        render json: { data: { message: 'Error: Item Not Found' } }
      end
    else
        render status: 400
      end
    end
end
