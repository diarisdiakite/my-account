class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_and_categories
  before_action :set_category, only: %i[index new create]
  before_action :set_expense, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /expenses or /expenses.json
  def index
    @user = User.find(params[:user_id])
    @categories = @user.categories
    @category = @categories.find(params[:category_id]) if params[:category_id].present?
    @expenses = @category.present? ? @category.expenses : Expense.where(category: @categories)
  end

  # GET /expenses/1 or /expenses/1.json
  def show; end

  # GET /expenses/new
  def new
    @user = User.find(params[:user_id])
    @category = @user.categories.find(params[:category_id])
    @categories = Category.all
    @expense = @category.expenses.build(author: @user)
  end

  # GET /expenses/1/edit
  def edit; end

  # POST /expenses or /expenses.json
  def create
    @user = User.find(params[:user_id])
    @category = @user.categories.find(params[:category_id])
    @expense = @category.expenses.new(expense_params)

    # Explicitly set author_id
    @expense.author_id = @user.id

    @expense.category_ids = Array(params[:expense][:category_ids]).reject(&:empty?)

    respond_to do |format|
      if @expense.save
        format.html do
          redirect_to user_category_expenses_path(@user, @category), notice: 'Expense was successfully created.'
        end
        format.json { render :show, status: :created, location: @expense }
      else
        @categories = @user.categories.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_user_and_categories
    @user = User.find(params[:user_id])
    @categories = @user.categories
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_expense
    @expense = Expense.find(params[:id])
  end

  def set_category
    @category = @categories.find(params[:category_id]) if params[:category_id].present?
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:author_id, :name, :amount, category_ids: [])
  end
end
