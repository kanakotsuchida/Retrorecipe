class AddImpressionsCountToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :impressions_count, :integer
  end
end
