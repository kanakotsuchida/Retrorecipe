class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  belongs_to :recipe, optional: true, counter_cache: :favorites_count
  
  #has_many :recipes_tags, dependent: :destroy
  #has_many :images, dependent: :destroy
  #has_many :recipe_tags, through: :recipe_tags
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
 
  has_many :favorites_users, through: :favorites, source: :user

  has_one_attached :image
  validates :name, presence: true, length: { maximum: 20 }
  validates :ingredient, :method, :cooking_time, :serve, :genre_id, presence: true
 

  enum cooking_time: {
    '30分以下': 1, '60分以下': 2, '60分以上': 3,
  }

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @recipe = Recipe.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @recipe = Recipe.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @recipe = Recipe.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @recipe = Recipe.where("name LIKE?","%#{word}%")
    else
      @recipe = Recipe.all
    end
  end
  
  def favorited?(user)
   favorites.where(user_id: user.id).exists?
  end 
  
  
  
end
