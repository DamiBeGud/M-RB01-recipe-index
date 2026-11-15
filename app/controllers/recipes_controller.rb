class RecipesController < ApplicationController
  def create
    title=Input.text(params[:title],120);ids=Input.ingredients(params[:ingredient_ids])
    recipe=Recipe.transaction do
      raise Problem.new(400,'unknown_ingredient') unless Ingredient.where(id:ids).count==ids.length
      row=Recipe.create!(title:title);row.ingredient_ids=ids;row
    end
    render json:serialize(recipe),status: :created
  end
  def show = render(json:serialize(Recipe.includes(:ingredients).find(params[:id])))
  def index
    rows=Recipe.all
    rows=rows.joins(:ingredients).where(ingredients:{name:Input.text(params[:ingredient],40).downcase}) if params[:ingredient].present?
    if params[:exclude_allergen].present?
      excluded=Recipe.joins(:ingredients).where(ingredients:{allergen:Input.text(params[:exclude_allergen],40).downcase}).select(:id)
      rows=rows.where.not(id:excluded)
    end
    render json:{recipes:rows.distinct.includes(:ingredients).order(:id).limit(100).map{|r|serialize(r)}}
  end
  private
  def serialize(row) = {id:row.id,title:row.title,ingredients:row.ingredients.sort_by(&:id).map{|i|{id:i.id,name:i.name,allergen:i.allergen}}}
end
