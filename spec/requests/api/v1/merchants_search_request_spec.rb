require 'rails_helper'

describe "Merchants Search API" do
  it "can find a merchant from a partial search" do
    merchant_1 = create(:merchant, name: "Trotar")
    merchant_2 = create(:merchant, name: "Correr")
    merchant_3 = create(:merchant, name: "Corres")

    get "/api/v1/merchants/find?name=Corre"

    merchant = JSON.parse(response.body, symbolize_names: true)
    response_data = merchant[:data][:attributes][:name]

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(response_data).to eq(merchant_2.name)
    expect(response_data).to_not eq(merchant_1.name)
    expect(response_data).to_not eq(merchant_3.name)

    expect(merchant).to be_an(Hash)
    expect(merchant[:data]).to be_an(Hash)

    data = merchant[:data]

    expect(data).to have_key(:id)
    expect(data[:id].to_s).to eq("#{merchant_2.id}")
    expect(data[:attributes]).to have_key(:name)
    expect(data[:attributes][:name]).to eq(merchant_2.name)
    expect(data).to have_key(:type)
    expect(data[:type]).to be_an(String)
  end

  it "can find all merchants from a partial search" do
    merchant_1 = create(:merchant, name: "Trotar")
    merchant_2 = create(:merchant, name: "Correr")
    merchant_3 = create(:merchant, name: "Corres")

    get "/api/v1/merchants/find_all?name=Corr"

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(200)

    merchants_array = merchants[:data]

    expect(merchants_array).to be_an(Array)

    expect(merchants_array.count).to eq(2)
    expect(merchants_array.first).to have_key(:id)

    expect(merchants_array.first[:id]).to eq("#{merchant_2.id}")
    expect(merchants_array.first).to have_key(:type)

    expect(merchants_array.last[:id]).to eq("#{merchant_3.id}")
    expect(merchants_array.first).to have_key(:attributes)

    first_attributes = merchants_array.first[:attributes]
    expect(first_attributes).to have_key(:name)
    expect(first_attributes[:name]).to be_an(String)

    expect(first_attributes[:name]).to eq("#{merchant_2.name}")
    expect(first_attributes[:name]).to_not eq("#{merchant_1.name}")

    last_attributes = merchants_array.last[:attributes]
    expect(last_attributes).to have_key(:name)
    expect(last_attributes[:name]).to be_an(String)

    expect(last_attributes[:name]).to eq("#{merchant_3.name}")
    expect(first_attributes[:name]).to_not eq("#{merchant_1.name}")
  end

  it 'sad path, empty search doesnt matched' do
    merchant_1 = create(:merchant, name: "Trotar")
    merchant_2 = create(:merchant, name: "Correr")
    merchant_3 = create(:merchant, name: "Corres")

    get "/api/v1/merchants/find?name="

    expect(response).to_not be_successful
    expect(response.code).to eq("400")
    expect(response.status).to eq(400)
  end
end
