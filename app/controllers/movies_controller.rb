class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings

    # Get the remembered settings
    if (params[:filter] == nil or params[:ratings] == nil or params[:sort] == nil)
      if (params[:filter] == nil and session[:filter] != nil)
        params[:filter] = session[:filter]
      elsif (params[:ratings] == nil and session[:ratings] != nil)
        params[:ratings] = session[:ratings]
      elsif (params[:sort] == nil and session[:sort] != nil)
        params[:sort] = session[:sort]
      end
      redirect_to :action => "index", :params => {:filter => params[:filter], :ratings => params[:ratings], :sort => params[:sort]}
    else
      if (params[:filter] != nil)
        @filtered_ratings = params[:filter].scan(/[\w-]+/)
        session[:filter] = params[:filter]
      else
        @filtered_ratings = params[:ratings] ? params[:ratings].keys : []
      end
      
      session[:ratings] = params[:ratings]
      if (params[:sort] == "title") # Sort by titles
        session[:sort] = "title"
        if (params[:ratings] or params[:filter]) # filter ratings
          @movies = Movie.find(:all, :conditions => {:rating => @filtered_ratings}, :order => "title")
        else
          @movies = Movie.find(:all, :order => "title")
        end
      elsif (params[:sort] == "release_date") # Sort by release_date
        session[:sort] = "release_date"
        if (params[:ratings] or params[:filter]) # filter ratings
          @movies = Movie.find(:all, :conditions => {:rating => @filtered_ratings}, :order => "release_date")
        else
          @movies = Movie.find(:all, :order => "release_date")
        end
      elsif (params[:sort] == nil)
        session.delete(:sort)
        if (params[:ratings] or params[:filter]) # filter ratings
          @movies = Movie.find(:all, :conditions => {:rating => @filtered_ratings})
        else
          @movies = Movie.all
        end
      end
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
