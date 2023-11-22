class CategoryExpensesController < ApplicationController
  before_action :set_category_expense, only: %i[ show edit update destroy ]

  # GET /category_expenses or /category_expenses.json
  def index
    @category_expenses = CategoryExpense.all
  end

  # GET /category_expenses/1 or /category_expenses/1.json
  def show
  end

  # GET /category_expenses/new
  def new
    @category_expense = CategoryExpense.new
  end

  # GET /category_expenses/1/edit
  def edit
  end

  # POST /category_expenses or /category_expenses.json
  def create
    @category_expense = CategoryExpense.new(category_expense_params)

    respond_to do |format|
      if @category_expense.save
        format.html { redirect_to category_expense_url(@category_expense), notice: "Category expense was successfully created." }
        format.json { render :show, status: :created, location: @category_expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /category_expenses/1 or /category_expenses/1.json
  def update
    respond_to do |format|
      if @category_expense.update(category_expense_params)
        format.html { redirect_to category_expense_url(@category_expense), notice: "Category expense was successfully updated." }
        format.json { render :show, status: :ok, location: @category_expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_expenses/1 or /category_expenses/1.json
  def destroy
    @category_expense.destroy

    respond_to do |format|
      format.html { redirect_to category_expenses_url, notice: "Category expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_expense
      @category_expense = CategoryExpense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_expense_params
      params.require(:category_expense).permit(:expense_id, :category_id)
    end
end
