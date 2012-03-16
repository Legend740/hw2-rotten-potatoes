class Movie < ActiveRecord::Base
  class << self
    attr_writer :all_ratings
  end
  def all_ratings
    if (@all_ratings == nil)
      @all_ratings = ["G", "PG-13", "R", "PG"]
    end
    return @all_ratings
  end
  def rating=(value)
    if (@all_ratings == nil)
      @all_ratings = ["G", "PG-13", "R", "PG"]
    end
    if (@all_ratings.find_index(value) == nil)
      all_ratings.push(value)
    end
    @rating=value
  end
end
