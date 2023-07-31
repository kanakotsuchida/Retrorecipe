class Tag < ApplicationRecord
  has_many :recipe_tag, dependent: :destroy, foreign_key: 'tag_id'
  has_many :recipes, through: :recipe_tag

  validates :tag_name, uniqueness: true, presence: true
end
