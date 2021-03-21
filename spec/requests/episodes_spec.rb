require 'rails_helper'

RSpec.describe "Episodes", type: :request do
  let!(:season) { create(:season) }
  let(:season_id) { season.id }
  let(:episode_id) { season.episodes.first.id }

  describe 'GET /seasons/:season_id/episodes' do
    before { get "/seasons/#{season_id}/episodes" }

    context 'when season exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all season episodes' do
        expect(json.size).to eq(season.episodes.size)
      end
    end

    context 'when season does not exist' do
      let(:season_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Season/)
      end
    end
  end

  describe 'GET /seasons/:season_id/episodes/:id' do
    before { get "/seasons/#{season_id}/episodes/#{episode_id}" }

    context 'when season episode exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the episode' do
        expect(json['id']).to eq(episode_id)
        expect(json['title']).to eq(Episode.find(episode_id).title)
        expect(json['plot']).to eq(Episode.find(episode_id).plot)
        expect(json['season_episode_number']).to eq(Episode.find(episode_id).season_episode_number)
      end
    end

    context 'when season episode does not exist' do
      let(:episode_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Episode/)
      end
    end
  end

  describe 'POST /seasons/:season_id/episodes' do
    let(:valid_attributes) { { title: 'Title', plot: 'Plot', season_episode_number: 33, season_id: season_id } }

    context 'when request attributes are valid' do
      before { post "/seasons/#{season_id}/episodes", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/seasons/#{season_id}/episodes", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank, Plot can't be blank, Season episode number can't be blank/)
      end
    end
  end

  describe 'PUT /seasons/:season_id/episodes/:id' do
    let(:valid_attributes) { { title: 'Eltit' } }

    before { put "/seasons/#{season_id}/episodes/#{episode_id}", params: valid_attributes }

    context 'when episode exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the episode' do
        expect(Episode.find(episode_id).title).to match(/Eltit/)
        expect(response.body).to be_empty
      end
    end

    context 'when the episode does not exist' do
      let(:episode_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Episode/)
      end
    end
  end

  describe 'DELETE /seasons/:id' do
    before { delete "/seasons/#{season_id}/episodes/#{episode_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
