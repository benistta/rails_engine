require 'rails_helper'

RSpec.describe "Merchants API" do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    expect(response.status).to eq(200)

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_an(Hash)
    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  describe 'get one merchant endpoint' do
    it 'returns one merchant' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(merchant).to be_a(Hash)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
    end
  end

  it 'sad path, bad integer id returns 404' do
     merchant = create(:merchant)

     get "/api/v1/merchants/0000"

     error = JSON.parse(response.body, symbolize_names: true)
     expect(response).to_not be_successful
     expect(response).to_not eq(200)
     expect(response.code).to eq("404")

     expect(response.status).to eq(404)

     expect(error).to have_key(:message)
   end
end
