class CreateAccountStatements < ActiveRecord::Migration[7.0]
  def change
    create_table :account_statements do |t|
      t.string :name
      t.decimal :moved_value
      t.date :move_date
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
