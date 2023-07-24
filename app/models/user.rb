class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
 validates :name, presence: true
 
  has_many :recipes, dependent: :destroy
  has_many :profile_images, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  has_many :profiles, dependent: :destroy
  has_one_attached :profile_image
  belongs_to :user, optional: true
 
  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end
         
end
