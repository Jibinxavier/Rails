class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    redirect=false
    @all_ratings=Movie.getRatings
     
    selectRatings||=params[:ratings] || session[:ratings]
    if selectRatings!=nil
      @selectRatings=selectRatings
    else
      @selectRatings={}
      @all_ratings.each{|r| @selectRatings[r] = 1}
    end
    
     
    sort_by||=params[:sort]||session[:sort]
    
     if params[:sort]
    
      session[:sort]=sort_by
    elsif session[:sort]
    
      redirect=true
    end
    
    if params[:ratings]
    
      session[:ratings]=@selectRatings
    elsif session[:ratings]
    
      redirect=true
    end
    
    if redirect
      redirect_to movies_path(:sort => sort_by, :ratings => @selectRatings)
    end
    if sort_by=='title'
      @movies = Movie.where(rating: @selectRatings.keys).order("title ASC")
    elsif sort_by=='release_date'
      @movies = Movie.where(rating: @selectRatings.keys ).order("release_date ASC")
    else
      @movies = Movie.where(rating: @selectRatings.keys )
    end
    
  end

  def new
    # default: render 'new' template
  end
 
  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end