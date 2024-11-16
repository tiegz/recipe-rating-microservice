class CreateRecipeRatings < ActiveRecord::Migration[7.2]
  def change
    create_table :recipe_ratings, id: :uuid do |t|
      t.string :recipe_id
      t.string :user_id
      t.integer :rating
      t.string :comment
      t.timestamps null: false
    end
  end
end
