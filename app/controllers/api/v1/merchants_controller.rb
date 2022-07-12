class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
    # render json: MerchantSerializer.format_index(Merchant.all)
  end

  def show

    merchant = Merchant.find(params[:id])
    # render json: MerchantSerializer.format_show(merchant)
    
    render json: MerchantSerializer.new(merchant)
  end
end
