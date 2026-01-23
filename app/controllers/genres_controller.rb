class GenresController < ApplicationController
 def index
   @genres = Genre.all
    render :index
 end

 def create 
  @genre = Genre.create(
    name: params[:name]
  )
  render :show
 end
end
