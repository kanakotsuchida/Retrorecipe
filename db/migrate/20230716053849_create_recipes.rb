class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|

      t.string :title, null: false
      t.text :body, null: false
      t.string :ingredient, null: false
      t.text :memo
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
