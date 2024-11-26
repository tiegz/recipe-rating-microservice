# frozen_string_literal: true
require "bundler/setup" #needed to add this line for the env setup to work on my machine!! *** using github codespaces
Bundler.require

$LOAD_PATH << "."

require 'sinatra'
require 'sinatra/activerecord'
require 'models/recipe_rating'

set :database, 'sqlite3:database.db'
set :bind, '0.0.0.0'
set :port, 9292

# Simulate a logged-in user by always using the same user id, for now.
FIXED_USER_ID = "085ebd10-2135-43ec-acc7-785f0d00fc8a"

class RecipeRatingsApp < Sinatra::Base
  # Example response:
  # Response: {"recipe_id": "111", "rating": 10}
  get "/retrieve_rating/:id" do
    recipe_rating = RecipeRating.find_by(user_id: FIXED_USER_ID, recipe_id: params["id"])

    if recipe_rating.nil?
      status 404 # not found
      { errors: ["Recipe rating not found for recipe_id='#{params["id"]}'"] }.to_json
    else
      status 200
      recipe_rating.to_json
    end
  end

  # Example response:
  #   {"recipe_id": "111", "rating": 10}
  get "/retrieve_latest_ratings/:id" do
    scope = RecipeRating.where(recipe_id: params["id"])

    if scope.count.zero?
      status 404 # not found
      { errors: ["Recipe ratings not found for recipe_id='#{params["id"]}'"] }.to_json
    else
      recipe_ratings = scope.order("updated_at DESC")
        .limit(20)
        .map { |rr| rr.slice(:recipe_id, :rating, :comment, :user_id) }
      status 200
      recipe_ratings.to_json
    end
  end

  # Example request: 
  #   { "recipe_id": "111", "rating": 10, "optional_comment": ""}
  post '/submit_rating' do
    recipe_id, rating, optional_comment = *params.values_at(:recipe_id, :rating, :optional_comment)
    rating = rating && rating.to_i
    errors = []

    errors << "'recipe_id' is missing" if recipe_id.nil?
    errors << "'rating' is missing" if rating.nil?
    errors << "'rating' is invalid (valid values: 1-10)" if rating && !(0..10).include?(rating)

    recipe_rating = RecipeRating
      .find_or_initialize_by(user_id: FIXED_USER_ID, recipe_id: recipe_id)
    recipe_rating.id ||= SecureRandom.uuid
    recipe_rating.update!(rating: rating, comment: optional_comment)

    if errors.size > 0
      status 422 # unprocessable entity
      { errors: errors }.to_json
    else
      status 201 # created
      recipe_rating.to_json
    end
  end

  # Example response: 
  #   {"recipe_id": "111", "average_rating": 7.22}
  get "/retrieve_average_rating/:id" do
    scope = RecipeRating.where(recipe_id: params["id"])

    if scope.count.zero?
      status 404 # not found
      { errors: ["Recipe ratings not found for recipe_id='#{params["id"]}'"] }.to_json
    else
      average_rating = RecipeRating.where(recipe_id: params["id"]).average(:rating)
      status 200
      {recipe_id: params["id"], ratings_count: scope.count, average_rating: average_rating}.to_json
    end
  end
end
