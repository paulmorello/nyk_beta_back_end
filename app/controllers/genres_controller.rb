class GenresController < ApplicationController

  def index
    @genres = Genre.all
    @presstypes = Presstype.all
    @countries = Country.all
    render json: {genres: @genres, presstypes: @presstypes, countries: @countries}
  end

end
