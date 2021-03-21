class MoviesSeasonsController < ApplicationController
  def movies_seasons_ordered_by_created_at
    render json: (Movie.all + Season.all).sort{|a,b| a.created_at <=> b.created_at }
  end
end
