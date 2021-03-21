require 'rails_helper'

RSpec.describe "Purchases", type: :request do
  let!(:user) { create(:user_purchases) }
  let(:user_id) { user.id }
  let(:purchase_id) { user.purchases.first.id }

  describe 'GET /users/:user_id/purchases' do
    before { get "/users/#{user_id}/purchases" }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user purchases' do
        expect(json.size).to eq(user.purchases.size)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'GET /users/:user_id/purchases/:id' do
    before { get "/users/#{user_id}/purchases/#{purchase_id}" }

    context 'when user purchase exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the purchase' do
        expect(json['id']).to eq(purchase_id)
        expect(json['quality']).to eq(Purchase.find(purchase_id).quality)
        expect(json['price']).to eq(Purchase.find(purchase_id).price)
        expect(json['purchasable_id']).to eq(Purchase.find(purchase_id).purchasable_id)
        expect(json['purchasable_type']).to eq(Purchase.find(purchase_id).purchasable_type)
        expect(json['begin_at'].to_datetime).to eq(Purchase.find(purchase_id).begin_at.to_datetime)
        expect(json['end_at'].to_datetime).to eq(Purchase.find(purchase_id).end_at.to_datetime)
      end
    end

    context 'when user purchase does not exist' do
      let(:purchase_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Purchase/)
      end
    end
  end

  describe 'POST /users/:user_id/purchases' do
    let(:movie) { create(:movie) }
    let(:movie_id) { movie.id }
    let(:valid_attributes) { { quality: 'HD', price: '2,99', purchasable_id: movie_id, purchasable_type: 'Movie', user_id: user_id, begin_at: DateTime.now, end_at: DateTime.now + 2.days } }

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/purchases", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when purchase already exist in user library' do
      before { Purchase.create!(quality: 'HD', price: '2,99', purchasable_id: movie_id, purchasable_type: 'Movie', user_id: user_id, begin_at: DateTime.now, end_at: DateTime.now + 2.days) }
      before { post "/users/#{user_id}/purchases", params: valid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
        expect(response.body).to match(/The Movie is already in your library/)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/purchases", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Quality can't be blank, Price can't be blank, Purchasable can't be blank, Purchasable type can't be blank, Begin at can't be blank, End at can't be blank/)
      end
    end
  end

  describe 'PUT /users/:user_id/purchases/:id' do
    let(:valid_attributes) { { quality: 'SD' } }

    before { put "/users/#{user_id}/purchases/#{purchase_id}", params: valid_attributes }

    context 'when purchase exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the purchase' do
        expect(Purchase.find(purchase_id).quality).to match(/SD/)
        expect(response.body).to be_empty
      end
    end

    context 'when the purchase does not exist' do
      let(:purchase_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Purchase/)
      end
    end
  end

  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}/purchases/#{purchase_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
