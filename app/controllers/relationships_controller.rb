class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    following = current_user.relationships.build(follower_id: params[:user_id])
    following.save
    redirect_to request.referrer 
  end

  def destroy
    following = current_user.relationships.find_by(follower_id: params[:user_id])
    following.destroy
    redirect_to request.referrer 
  end
 
 # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
 
 
end