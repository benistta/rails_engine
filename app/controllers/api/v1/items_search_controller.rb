class Api::V1::ItemsSearchController < ApplicationController
  def find_all
    items = Item.find_all_items(params[:name])
    render json: ItemSerializer.new(items)
  end
end
