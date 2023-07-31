class AddRecipeImageIdToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :recipe_image_id, :string
  end
end
