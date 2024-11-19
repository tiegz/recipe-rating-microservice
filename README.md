# Recipe Ratings Microservice

This app is a JSON HTTP REST API that allows users to submit and retrieve ratings for recipes.

Currently, the microservice assumes the same user is logged in, and uses the same dummy UUID for all user_id parameters.

It can be run in two ways:

#### Via Ruby:

```
bundle install
bundle exec puma config.ru --log-requests
```

#### Via Docker:

`docker run -p 9292:9292 -it $(docker build -q .)`

### API Communication Contract

#### POST /submit_rating

Submit your rating for a recipe with an HTTP request to the path "/submit_rating".

##### Example

```shell
curl --silent -X POST \
  -d "recipe_id=1" \
  -d "rating=3" \
  -d "optional_comment=This+is+a+comment" \
  http://localhost:9292/submit_rating
```

#### GET /retrieve_rating/RECIPE_ID

Retrieve your rating for a recipe using an HTTP request to the path "/retrieve_rating/RECIPE_ID", where RECIPE_ID is the id of the recipe.

##### Example

```shell
curl --silent http://localhost:9292/retrieve_rating/1
```

#### GET /retreive_average_rating/RECIPE_ID

Retrieve the average rating for a recipe using an HTTP request to the path "/retreive_average_rating/RECIPE_ID", where RECIPE_ID is the id of the recipe.

##### Example

```shell
curl --silent http://localhost:9292/retreive_average_rating/1
```


#### GET /retrieve_latest_ratings/RECIPE_ID

Retrieve the latest 20 ratings for a recipe using an HTTP request to the path "/retrieve_latest_ratings/RECIPE_ID", where RECIPE_ID is the id of the recipe.

##### Example

```shell
curl --silent http://localhost:9292/retrieve_latest_ratings/1
```
