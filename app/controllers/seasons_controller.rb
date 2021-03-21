class SeasonsController < ApplicationController
  before_action :set_season, only: [:show, :update, :destroy]

  def index
    @seasons = Season.all
    render json: @seasons
  end

  def create
    @season = Season.create!(season_params)
    render json: @season, status: :created
  end

  def show
    render json: @season
  end

  def update
    @season.update(season_params)
    head :no_content
  end

  def destroy
    @season.destroy
    head :no_content
  end

  def seasons_with_episodes_ordered
    seasons = Season.includes(:episodes_ordered_by_season_number)
    season_episodes = Rails.cache.fetch(Season.cache_key(seasons)) do
      seasons.to_json(include: :episodes_ordered_by_season_number)
    end

    render json: season_episodes
  end

  private

  def season_params
    params.permit(:title, :plot, :number)
  end

  def set_season
    @season = Season.find(params[:id])
  end
end
