json.extract! category_expense, :id, :expense_id, :category_id, :created_at, :updated_at
json.url category_expense_url(category_expense, format: :json)
