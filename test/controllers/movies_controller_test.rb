require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
test "index" do
  get "/movies.json"
  assert_response 200

  data = JSON.parse(response.body)
  assert_equal Movie.count, data.length
end

test "show" do 
  
end

test "create" do 
  assert_difference "Movie.count", 1 do
    post "/movies.json", params: {name: "Avengers", movie_url: "Avenger.mp4", poster: "avengers.jpg", overview: "superhero movie", actors: "RDJ, Chris Evans", rating: 8, user_rating: 8, release_date: "2012", run_time: "2 hrs"}
    assert_response 200
end

test "update" do 

end

test "destroy" do 

end

end
