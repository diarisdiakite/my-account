class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]
  load_and_authorize_resource except: [:destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  # GET /categories or /categories.json
  def index
    @user = current_user
    @categories = Category.all
  end

  # GET /categories/1 or /categories/1.json
  def show
    @user = current_user
    @categories = @user.categories
    @category = @user.categories.find(params[:id])
    @expenses = @category.expenses
    @expense = @user.categories.flat_map(&:expenses).find(params[:id])
  end

  # GET /categories/new
  def new
    @user = current_user
    @category = current_user.categories.new
  end

  # GET /categories/1/edit
  def edit
    @user = current_user
    @category = @user.categories.find(params[:id])
  end

  # POST /categories or /categories.json
  def create
    @user = current_user
    @category = current_user.categories.new(category_params)
    authorize! :create, @category

    respond_to do |format|
      if @category.save
        format.html { redirect_to user_url(@user), notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    @user = current_user
    @category = current_user.categories.find(params[:id])

    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to user_categories_url, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @user = current_user
    @category = @user.categories.find(params[:id])

    # Update foreign key references in category_expenses table
    @category.category_expenses.destroy_all

    # Then destroy the category
    @category.destroy

    respond_to do |format|
      format.html { redirect_to user_categories_url(@user), notice: 'Category was successfully destroyed.' and return }
      format.json { head :no_content }
    end

    @category.destroy
    respond_to do |format|
      format.html { redirect_to user_categories_url(@user), notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  def not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :icon, expense_ids: [])
  end
end
