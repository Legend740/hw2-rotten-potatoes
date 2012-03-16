class Movie < ActiveRecord::Base
  class << self; attr_accessor :comparing_field end
  def <=>(other_movie)
    if (@comparing_field == "title_header")
      return self.title <=> other_movie.title
    elsif (@comparing_field == "release_date_header")
      return self.release_date <=> other_movie.release_date
    end
  end
end
