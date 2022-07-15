require 'rails_helper'

describe 'Items Search API Endpoints' do
  it 'can find all items from a partial search' do
    hielo = create(:item, name: "Hielo")
    lila = create(:item, name: "Lila")
    fiel = create(:item, name: "Fiel")

    get '/api/v1/items/find_all?name=iE'

    expect(response).to be_successful
    expect(response.status).to eq(200)

    search = JSON.parse(response.body, symbolize_names: true)
    expect(search).to be_an(Hash)
    expect(search).to have_key(:data)

    data = search[:data]
    expect(data.count).to eq(2)
    expect(data).to be_an(Array)

    expect(data.first).to have_key(:id)

    expect(data.first[:id]).to eq("#{hielo.id}")
    expect(data.last[:id]).to eq("#{fiel.id}")

    expect(data[0].values.include?("#{lila.id}")).to eq(false)
    expect(data[1].values.include?("#{lila.id}")).to eq(false)

    expect(data.first).to have_key(:type)
    expect(data.first[:type]).to be_an(String)

    expect(data.first).to have_key(:attributes)

    attributes = data.first[:attributes]

    expect(attributes).to be_an(Hash)

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_an(String)

    expect(attributes).to have_key(:description)
    expect(attributes[:description]).to be_an(String)

    expect(attributes).to have_key(:unit_price)
    expect(attributes[:unit_price]).to be_an(Float)

    expect(attributes).to have_key(:merchant_id)
    expect(attributes[:merchant_id]).to be_an(Integer)
  end

  it 'sad path, empty search doesnt matched' do
    merchant = create(:merchant)
    hielo = create(:item, name: "Hielo")
    lila = create(:item, name: "Lila")
    fiel = create(:item, name: "Fiel")

    get '/api/v1/items/find?name='

    expect(response).to_not be_successful
    expect(response.code).to eq("400")
    expect(response.status).to eq(400)
  end
end
