class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
 def index
    @users = User.all
    
 end
  def show
    @user = User.find(params[:id])
    @following_users = @user.following_users
    @follower_users = @user.follower_users
    
  end
  def edit
    @user = User.find(params[:id])
    if @user != current_user
        redirect_to user_path(current_user), alert: "不正なアクセスです。"
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      render :edit
    end
  end

def favorites
  @user = User.find(params[:id])
  favorites = Favorite.where(user_id: @user.id).pluck(:recipe_id)
  @favorite_recipes = Recipe.find(favorites)
end

 
 # フォロー一覧
def follows
  user = User.find(params[:id])
  @users = user.following_users
end

# フォロワー一覧
def followers
  user = User.find(params[:id])
  @user = user.follower_users
end

 

  private
  def user_params
    params.require(:user).permit(:name, :email, :profile_id, :profile_image)
  end
end 

