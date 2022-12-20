class AccountStatementsController < ApplicationController
  def filter
    initial_date = params[:initial_date].to_date
    end_date = params[:end_date].to_date
    @statements = AccountStatement.where(move_date: initial_date..end_date)
  end
end
