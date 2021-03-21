require 'rails_helper'

RSpec.describe "MoviesSeasons", type: :request do
  let!(:movies) { create_list(:movie, 3) }
  let!(:seasons) { create_list(:season, 3, number: 1) }

  describe "GET /movies_seasons_ordered_by_created_at" do
    before { get '/movies_seasons_ordered_by_created_at' }

    it 'returns movies and seasons' do
      expect(json).not_to be_empty
      expect(json.size).to eq(6)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
