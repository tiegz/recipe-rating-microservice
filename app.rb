# frozen_string_literal: true

Bundler.require

$LOAD_PATH << "."

require 'sinatra'
require 'sinatra/activerecord'
require 'models/recipe_rating'

set :database, 'sqlite3:database.db'
set :bind, '0.0.0.0'

# Simulate a logged-in user by always using the same user id, for now.
FIXED_USER_ID = "565ebd10-2135-43ec-acc7-785f0d00fc8a"

class RecipeRatingsApp < Sinatra::Base
  # Example request: 
  #   { "recipe_id": "111", "rating": 10, "optional_comment": ""}
  post '/submit_rating' do
    recipe_id, rating, optional_comment = *params.values_at(:recipe_id, :rating, :optional_comment)
    rating = rating && rating.to_i
    errors = []

    errors << "'recipe_id' is missing" if recipe_id.nil?
    errors << "'rating' is missing" if rating.nil?
    errors << "'rating' is invalid (valid values: 1-10)" if rating && !(0..10).include?(rating)

    recipe_rating = RecipeRating.find_or_initialize_by(
      user_id: FIXED_USER_ID,
      recipe_id: recipe_id
    ) do |rr|
      rr.id ||= SecureRandom.uuid
    end
    recipe_rating.update!(rating: rating, comment: optional_comment)

    if errors.size > 0
      status 422 # unprocessable entity
      { errors: errors }.to_json
    else
      status 201 # created
      recipe_rating.to_json
    end
  end
end
