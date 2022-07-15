class Api::V1::MerchantsController < ApplicationController
  
  def index
    render(json: MerchantSerializer.new(Merchant.all), statu: :ok)
  end

  def show
    merchant = Merchant.find(params[:id])
    render(json: MerchantSerializer.new(merchant), status: :ok)
  end
end
