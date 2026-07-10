class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :membership, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.date :due_on, null: false
      t.date :paid_on

      t.timestamps
    end
  end
end
