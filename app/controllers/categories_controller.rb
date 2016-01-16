class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = current_user.categories
  end
  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category= current_user.categories.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    # render json: params
    # return
    @category = current_user.categories.new(category_params)
    @category.save
    redirect_to categories_path, notice: 'Category was successfully created.'
  end

  def update
        @category.update_attributes(category_params)
        redirect_to categories_path, notice: 'category was successfully updated.'
  end

  # DELETE /categories/1
  # DELETE /categories/1.jsons
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = current_user.categories.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:source, :description, :type)
    end
end
