class Recipe < ApplicationRecord


  belongs_to :user
  belongs_to :genre
  has_many :recipes_tags, dependent: :destroy
  has_many :recipes_images, dependent: :destroy
  has_many :recipe_tags, through: :recipe_tags

  has_one_attached :resipe_image
  validates :name, presence: true, length: { maximum: 20 }
  validates :ingredient, :method, :cooking_time, :serve, :genre_id, presence: true
 

  enum cooking_time: {
    '30分以下': 1, '60分以下': 2, '60分以上': 3, '半日以上': 4, '一晩': 5,
  }

  # 検索機能
  def self.search(keyword)
    return current_user.recipes() unless keyword
    Recipe.where(["name LIKE(?)", "#{keyword}%"])
  end

  # タグ機能
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      tag = Tag.find_by(tag_name: old)
      self.recipe_tags.delete RecipeTag.find_by(tag_id: tag.id, recipe_id: self.id)
    end
    # ↑今あるタグを削除
    # ↓新しくタグを作る
    new_tags.each do |new|
      new_tag = Tag.find_or_create_by(tag_name: new)
      unless RecipeTag.exists?(tag_id: new_tag.id, recipe_id: self.id)
        new_recipe_tag = RecipeTag.create(tag_id: new_tag.id, recipe_id: self.id)
        self.recipe_tags << new_recipe_tag
      end
    end
  end
  
  
   def get_image
    unless recipe_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
   end
end

