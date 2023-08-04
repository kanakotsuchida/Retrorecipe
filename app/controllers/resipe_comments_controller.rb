class ResipeCommentsController < ApplicationController
  def create
    @recipe = RecipeImage.find(params[:recipe_image_id])
    comment = current_user.recipe_comments.new(recipe_comment_params)
    comment.recipe_image_id = recipe_image.id
    comment.save
    redirect_to recipe_image_path(recipe_image)
  end

  private

  def recipe_comment_params
    params.require(:recipe_comment).permit(:comment)
  end

end

