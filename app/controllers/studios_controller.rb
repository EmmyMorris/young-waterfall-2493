class StudiosController < ApplicationController
  def show
    @studio = Studio.find(params[:id])
    @movies = @studio.movies.all
    @actors = Actor.where(params[:currently_working] == true)
    # @actors = @movies.map { |m| m.actors }
    @movie_actors = @actors.order_by_age
  end
end
