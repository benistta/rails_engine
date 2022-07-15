require 'rails_helper'

 RSpec.describe 'Item Merchant Request' do
   describe 'getting an Items Merchant' do
     it 'can get the merchant data with item id' do

       merchant_2 = create(:merchant)
       merchant_3 = create(:merchant)
       item = create(:item, merchant_id: merchant_2.id)

       get "/api/v1/items/#{item.id}/merchant"

       merchant = JSON.parse(response.body, symbolize_names: true)
       expect(merchant[:data][:id].to_i).to eq(merchant_2.id)
       expect(merchant[:data][:attributes][:name]).to eq(merchant_2.name)
       expect(item.merchant_id).to eq(merchant[:data][:id].to_i)
     end
   end

   it 'sad path, bad integer id returns 404' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get '/api/v1/items/0000/merchant'

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end

  it 'edge case, string id returns 404' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get '/api/v1/items/blah/merchant'

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    end
 end
