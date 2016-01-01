class Movie < ActiveRecord::Base
    
   def self.getRatings
  	@result=Movie.pluck('rating').uniq
    #@res=result.select("DISTINCT(badges.id)")
  end
end
