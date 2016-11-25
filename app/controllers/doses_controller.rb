class DosesController < ApplicationController

  before_action :find_cocktail, only: [:new, :create]

  def new
    @dose        = Dose.new
    @ingredients = Ingredient.all
    # @ingredients_names = Ingredient.pluck(:name)
  end

  def create
    ingredient        = Ingredient.find(dose_params[:ingredient_id])
    @dose             = Dose.new(dose_params)
    @dose.ingredient  = ingredient
    @dose.cocktail    = @cocktail

    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render "new"
    end
  end

  def destroy
    dose = Dose.find(params[:id])
    cocktail = dose.cocktail

    dose.destroy
    redirect_to cocktail_path(cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

end
