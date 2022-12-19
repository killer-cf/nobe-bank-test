class AddCashToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :cash, :decimal, default: 0.0
  end
end
