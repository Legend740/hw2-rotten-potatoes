class Movie < ActiveRecord::Base
  class << self
    attr_accessor :all_ratings
  end
  @all_ratings = []
  def rating=(value)
    if (@all_ratings.find_index(value) == nil)
      all_ratings.push(value)
    end
    @rating=value
end
