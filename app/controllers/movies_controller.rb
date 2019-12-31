class MoviesController < ApplicationController

  def index
    movies = Movie.all.order(:start_date)
    render json: movies
  end

  def create
    movie = Movie.new permit_params
    if movie.save
      render status: 200, json: { movie: movie, message: 'Película creada correctamente' }
    else
      errors = movie.errors.full_messages.to_sentence
      render status: 412, json: { message: errors }
    end
  end

  def by_date
    movies = Movie.search_by_dates(search_params[:start_date], search_params[:end_date])
    if movies.present?
      render status: 200, json: movies
    else
      render status: 404, json: { message: 'No hay cartelera disponible para
        esta fecha'}
    end
  end

  private

  def permit_params
    params.require(:movie).permit(:end_date, :description, :name, :start_date, :url_image)
  end

  def search_params
    params.permit(:end_date, :start_date)
  end

end
