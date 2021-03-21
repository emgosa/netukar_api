require 'rails_helper'

RSpec.describe "Movies", type: :request do
  let!(:movies) { create_list(:movie, 3) }
  let(:movie_id) { movies.first.id }

  describe 'GET /movies' do
    before { get '/movies' }

    it 'returns movies' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /movies/:id' do
    before { get "/movies/#{movie_id}" }

    context 'when the record exists' do
      it 'returns the movie' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(movie_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:movie_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Movie/)
      end
    end
  end

  describe 'POST /movies' do
    let(:valid_attributes) { { title: 'Title', plot: 'Plot' } }

    context 'when the request is valid' do
      before { post '/movies', params: valid_attributes }

      it 'creates a movie' do
        expect(json['title']).to eq('Title')
        expect(json['plot']).to eq('Plot')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/movies', params: { title: 'Title' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Plot can't be blank/)
      end
    end
  end

  describe 'PUT /movies/:id' do
    let(:valid_attributes) { { title: 'eltiT' } }

    context 'when the record exists' do
      before { put "/movies/#{movie_id}", params: valid_attributes }

      it 'updates the movie' do
        expect(Movie.find(movie_id).title).to match(/eltiT/)
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /movies/:id' do
    before { delete "/movies/#{movie_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
