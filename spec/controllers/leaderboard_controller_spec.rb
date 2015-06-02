require 'rails_helper'

RSpec.describe LeaderboardController, :type => :controller do

  describe '#index' do
    it 'return the score and rank of the user' do
      Leaderboard.create(name: 'John Doe', score: 20)
      get :index, name: 'John Doe'
      result = JSON.parse(response.body)
      expect(result['score']).to eq 20
    end

    it 'returns 404 if user is not found' do
      get :index, name: 'Jane Doe'
      expect(response.status).to eq 404
    end
  end

  describe '#create' do
    it 'will record the score of the named entity' do
      expect(Leaderboard.count).to eq 0
      post :create, { name: 'John Doe', score: 20 }
      expect(Leaderboard.count).to eq 1
      expect(Leaderboard.first.name).to eq 'John Doe'
      expect(Leaderboard.first.score).to eq 20
      expect(response.status).to eq 200
    end

    it 'will update the named entity if the user already exists' do
      Leaderboard.create(name: 'Janice Doe', score: 20)
      expect(Leaderboard.count).to eq 1
      post :create, { name: 'Janice Doe', score: 25 }
      expect(Leaderboard.count).to eq 1
      expect(Leaderboard.first.name).to eq 'Janice Doe'
      expect(Leaderboard.first.score).to eq 25
      expect(response.status).to eq 200
    end
  end
end
