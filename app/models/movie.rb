class Movie < ActiveRecord::Base
  attr_accessor :comparing_field
  def <=>(other)
    if (@comparing_field == "title_header")
      return self.title <=> other.title
    elsif (@comparing_field == "release_date_header")
      return self.release_date <=> other.release_date
    end
  end
end
