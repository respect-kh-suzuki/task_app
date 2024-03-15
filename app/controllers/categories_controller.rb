class CategoriesController < ApplicationController
  # GET /categories
  def index
    @categories = params[:status].nil? ? Category.all : Category.where(status: params[:status])
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # POST /categories
  def create
    @category = Category.new
    @category.attributes = params.require(:category).permit(:label)
    @category.save!

    redirect_to categories_path
  rescue ActiveRecord::RecordInvalid
    render action: :new, status: :unprocessable_entity
  end

  # GET /categories/:id/edit
  def edit
    @category = Category.find params[:id]
  end

  # PATCH /categories/:id
  def update
    @category = Category.find params[:id]
    @category.attributes = params.require(:category).permit(:label)
    @category.save!

    redirect_to categories_path
  rescue ActiveRecord::RecordInvalid
    render action: :edit, status: :unprocessable_entity
  end

  # DELETE /categories/:id
  def destroy
    @category = Category.find params[:id]
    @category.destroy
    redirect_to :categories
  end
end
