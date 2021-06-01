class StudiosController < ApplicationController
  def show
    @studio = Studio.find(params[:id])
    @movies = @studio.movies.all
    @actors = []
    @movies.each { |m| @actors << m.actors }
  end
end
