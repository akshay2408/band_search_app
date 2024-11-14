require 'rails_helper'

RSpec.describe Api::V1::BandsController, type: :controller do
  describe 'GET #index' do
    let(:city) { 'New York' }
    let(:bands) do
      [
        { 'id' => '1', 'name' => 'Band A', 'life-span' => { 'begin' => '2015' } },
        { 'id' => '2', 'name' => 'Band B', 'life-span' => { 'begin' => '2017' } }
      ]
    end

    before do
      allow(BandSearchService).to receive(:get_bands_by_location).and_return(bands)
      allow(BandSearchService).to receive(:get_user_location).and_return(city)
    end

    context 'when a city is provided as a parameter' do
      it 'fetches bands for the given city' do
        get :index, params: { city: city }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq(bands)
        expect(BandSearchService).to have_received(:get_bands_by_location).with(city)
      end
    end

    context 'when no city is provided as a parameter' do
      it 'fetches the user’s location and returns bands for that location' do
        get :index

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq(bands)
        expect(BandSearchService).to have_received(:get_user_location)
        expect(BandSearchService).to have_received(:get_bands_by_location).with(city)
      end
    end

    context 'when an error occurs during band fetching' do
      before do
        allow(BandSearchService).to receive(:get_bands_by_location).and_return([])
      end

      it 'returns an empty array when no bands are found' do
        get :index, params: { city: city }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end
end
