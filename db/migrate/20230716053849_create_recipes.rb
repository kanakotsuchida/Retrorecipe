class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.string :ingredient, null: false
      t.string :method, null: false
      t.integer :cooking_time
      t.integer :serve
      t.text :memo
      t.integer :user_id, null: false
      t.integer :genre_id, null: false
      
      t.timestamps
      
    end
  end
end
