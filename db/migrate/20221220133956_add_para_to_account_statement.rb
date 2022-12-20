class AddParaToAccountStatement < ActiveRecord::Migration[7.0]
  def change
    add_column :account_statements, :to, :string
    add_column :account_statements, :from, :string
  end
end
