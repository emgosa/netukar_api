require 'rails_helper'

RSpec.describe "Seasons", type: :request do
  let!(:seasons) { create_list(:season, 3, number: 1) }
  let(:season_id) { seasons.first.id }
  describe 'GET /seasons' do
    before { get '/seasons' }

    it 'returns seasons' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /seasons/:id' do
    before { get "/seasons/#{season_id}" }

    context 'when the record exists' do
      it 'returns the season' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(season_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:season_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Season/)
      end
    end
  end

  describe 'POST /seasons' do
    let(:valid_attributes) { { title: 'Title', plot: 'Plot', number: 1 } }

    context 'when the request is valid' do
      before { post '/seasons', params: valid_attributes }

      it 'creates a season' do
        expect(json['title']).to eq('Title')
        expect(json['plot']).to eq('Plot')
        expect(json['number']).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/seasons', params: { title: 'Title' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Plot can't be blank, Number can't be blank/)
      end
    end
  end

  describe 'PUT /seasons/:id' do
    let(:valid_attributes) { { title: 'eltiT' } }

    context 'when the record exists' do
      before { put "/seasons/#{season_id}", params: valid_attributes }

      it 'updates the season' do
        expect(response.body).to be_empty
        expect(Season.find(season_id).title).to match(/eltiT/)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /seasons/:id' do
    before { delete "/seasons/#{season_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
