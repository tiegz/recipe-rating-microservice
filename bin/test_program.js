const axios = require("axios");

const HOSTNAME = "http://localhost:9292";

async function submitRating(recipeId, rating, comment) {
  try {
    console.log(`Submitting rating for recipe_id=${recipeId}`);
    const response = await axios.post(`${HOSTNAME}/submit_rating`, null, {
      params: {
        recipe_id: recipeId,
        rating: rating,
        optional_comment: comment,
      },
    });
    console.log(response.data);
  } catch (error) {
    console.error("Error:", error.message);
  }
}

async function retrieveRating(recipeId) {
  try {
    console.log(`Retrieve rating for recipe_id=${recipeId}`);
    const response = await axios.get(
      `${HOSTNAME}/retrieve_rating/${recipeId}`
    );
    console.log(response.data);
  } catch (error) {
    console.error("Error:", error.message);
  }
}

async function retrieveAverageRating(recipeId) {
  try {
    console.log(`Retrieve average for recipe_id=${recipeId}`);
    const response = await axios.get(
      `${HOSTNAME}/retrieve_average_rating/${recipeId}`
    );
    console.log(response.data);
  } catch (error) {
    console.error("Error:", error.message);
  }
}

async function retrieveLatestRatings(recipeId) {
  try {
    console.log(`Retrieve latest ratings for recipe_id=${recipeId}`);
    const response = await axios.get(
      `${HOSTNAME}/retrieve_latest_ratings/${recipeId}`
    );
    console.log(response.data);
  } catch (error) {
    console.error("Error:", error.message);
  }
}

const sleep = (ms) =>
  new Promise((resolve) => {
    console.log("... next command in 5 seconds ...\n\n\n");
    setTimeout(resolve, ms);
  });

 (async () => {
   await submitRating(1, 7, "This is a new comment for my recipe review.");
   await sleep(5000);
   await retrieveRating(1);
   await sleep(5000);
   await retrieveAverageRating(1);
   await sleep(5000);
   await retrieveLatestRatings(1);
   console.log("\n\nDemo complete!");
 })();
