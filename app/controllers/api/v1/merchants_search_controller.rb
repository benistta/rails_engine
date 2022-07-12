class Api::V1::MerchantsSearchController < ApplicationController

  def find

    merchant = Merchant.find_merchant(params[:name])
    if merchant.nil?
      render json: { data: { :message => 'merchant not found'} }
      # render json: { data: {} }
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end
