class EpisodesController < ApplicationController
  before_action :set_season
  before_action :set_episode, only: [:show, :update, :destroy]

  def index
    render json: @season.episodes
  end

  def show
    render json: @episode
  end

  def create
    @season.episodes.create!(episode_params)
    render json: episode_params, status: :created
  end

  def update
    @episode.update(episode_params)
    head :no_content
  end

  def destroy
    @episode.destroy
    head :no_content
  end

  private

  def episode_params
    params.permit(:title, :plot, :season_episode_number, :season_id)
  end

  def set_season
    @season = Season.find(params[:season_id])
  end

  def set_episode
    @episode = @season.episodes.find(params[:id]) if @season
  end
end