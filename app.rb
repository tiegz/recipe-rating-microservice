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
end
