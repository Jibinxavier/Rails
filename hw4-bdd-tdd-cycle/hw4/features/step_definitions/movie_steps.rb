# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
     Movie.create!(movie)
  end
   
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
    /.#{e1}.(#{e2})/=~page.body
end
Then /the director of "(.*)" should be "(.*)"/ do |e1, e2|
  movie=Movie.find_by_title e1
  movie.director==e2
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
   
   
   split = rating_list.split(/\s*,\s*/)
   
 
     
    if uncheck
      split.each { |rating| uncheck("ratings_#{rating}") }
    else
    split.each { |rating| "When I check ratings_#{rating}" }

     end
  
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
   allMovies=Movie.all
   allMovies.each{|movie| expect(page).to have_content(movie.title) }
end
