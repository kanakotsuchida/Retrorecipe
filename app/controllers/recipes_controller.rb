class RecipesController < ApplicationController
    before_action :authenticate_user!, except: [:index]
  def index
    @recipes = Recipe.all.order(id: "DESC")
    
    @genres = Genre.all
    #@tag_list = Tag.all
    # ↓ジャンル検索
    if params[:genre_id]
      @genre = @genres.find(params[:genre_id])
      @recipes = @genre.recipes.where(@genre_id).page(params[:page])
    # ↓タグ検索
    elsif params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      #@recipes = @tag.recipes.where(user_id: current_user.id).page(params[:page]).per(5)
      @recipe_tag = @tag.tag_name
    # ↓すべて
    #else
      @recipes = current_user.recipes.page(params[:page]).per(5).order(id: "DESC")
    end
    #@all_recipes_count = @recipes.total_count
  end

  def show
    @recipe = Recipe.find(params[:id])
    #redirect_to users_path unless current_user == @recipe.user
    @comment = Comment.new #追記
    @comments = @recipe.comments.order(created_at: :desc) #追記
    
  end

  def new
    @recipe = Recipe.new
    @genre_list = Genre.pluck('name, id')
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
   
    if @recipe.save
      
      redirect_to recipe_path(@recipe.id), notice: "レシピを作成しました。"
    else
      @genre_list = Genre.pluck('name, id')
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @genre_list = Genre.pluck('name, id')
    if @recipe.user.id == current_user.id
      render :edit
    else
      redirect_to :recipes_path
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    @genres = Genre.all
    #tag_list = params[:recipe][:tag_name].split(nil)
    if @recipe.update(recipe_params)
      #@recipe.save_tag(tag_list)
      redirect_to recipe_path(@recipe.id), notice: 'レシピを更新しました。'
    else
      @genre_list = Genre.pluck('name, id')
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
    params.require(:recipe).permit(:name,:image, :ingredient, :method, :cooking_time, :serve, :memo, :genre_id, :recipes_tags)
  end
end