class HomesController < ApplicationController
  def index
  end
  
  def guest_sign_in
    user = User.find_or_create_by!(name: 'hanako', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
