class CategoriesController < ApplicationController

  # before_filter :category,
  #               :only => [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(params[:category])
    category.save
    redirect_to categories_path
  end

  def edit
  end

  def update
    category.update_attributes(params[:category])
    redirect_to categories_path
  end

  def destroy
    category.destroy
    redirect_to categories_path
  end

  helper_method :category

  private

  def category
    @category ||= Category.find(params[:id])
  end
  
end
