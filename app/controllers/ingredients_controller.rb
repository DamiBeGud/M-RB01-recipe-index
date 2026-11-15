class IngredientsController < ApplicationController
  def create
    row=Ingredient.create!(name:Input.text(params[:name],40).downcase,allergen:params[:allergen].nil? ? nil : Input.text(params[:allergen],40).downcase)
    render json:row.as_json(only:[:id,:name,:allergen]),status: :created
  end
end
