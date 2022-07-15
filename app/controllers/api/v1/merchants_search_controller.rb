class Api::V1::MerchantsSearchController < ApplicationController
  
  def find
    if params[:name].present?
    merchant = Merchant.find_merchant(params[:name])
      if merchant
        render json: MerchantSerializer.new(merchant)
      elsif merchant.nil?
        render json: { data: { message: 'Error: Merchant Not Found' } }
      end
    elsif params[:name].empty?
      render status: 400
    end
  end

  def find_all
    merchants = Merchant.find_all_merchants(params[:name])
    render json: MerchantSerializer.new(merchants) if merchants
  end
end
