class RecipesController < ApplicationController
 before_action :authenticate_user!, except: [:index]
  
  def index
    @recipes = Recipe.all
  end
  def show
    @recipe = Recipe.find(params[:id])
    redirect_to users_path unless current_user == @recipe.user
    @recipe_tags = @recipe.tags
    impressionist(@recipe, nil, unique: [:ip_address])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipe_path(@recipe.id), notice: "レシピを作成しました。"
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user.id == current_user.id
      render :edit
    else
      redirect_to :recipes_path
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      @recipe.save
      redirect_to recipe_path(@recipe.id), notice: 'レシピを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  def favorite
    @recipe = current_user.recipes.find(params[:id])
    if @recipe.favorite
      @recipe.update(favorite: false)
    else
      @recipe.update(favorite: true)
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title, :recipe_image_id, :ingredient, :memo, )
  end
 
end