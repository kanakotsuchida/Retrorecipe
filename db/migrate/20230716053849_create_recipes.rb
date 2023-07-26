class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.string :ingredient, null: false
      t.string :method, null: false
      t.integer :cooking_time, null: false
      t.integer :serve, null: false
      t.text :memo, null: false
      t.integer :user_id, null: false
      t.references :genre, foreign_key: true


      
    end
  end
end
