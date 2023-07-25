class Recipe < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :recipe_images, dependent: :destroy
  has_one_attached :recipe_image
  belongs_to :user

   
 

  
end