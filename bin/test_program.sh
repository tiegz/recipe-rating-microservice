echo "\n##################################"
echo "Submitting rating for recipe_id=1"
curl --silent -X POST -d "recipe_id=1" -d "rating=3" -d "optional_comment=This+is+a+comment" http://localhost:9292/submit_rating | jq
echo "##################################"
echo
echo
echo "\n##################################"
echo "Retrieve rating for recipe_id=1"
curl --silent http://localhost:9292/retrieve_rating/1 | jq
echo "##################################"
echo
echo
echo "\n##################################"
echo "Retrieve average for recipe_id=1"
curl --silent http://localhost:9292/retrieve_average_rating/1 | jq
echo "##################################"
echo
echo "\n##################################"
echo "Retrieve latest ratings for recipe_id=1"
curl --silent http://localhost:9292/retrieve_latest_ratings/1 | jq
echo "##################################"
echo

echo 
echo "Demo complete!"
echo