class CreateMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :memberships do |t|
      t.references :athlete, null: false, foreign_key: true
      t.references :package_plan, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.decimal :price_paid, precision: 10, scale: 2, null: false
      t.datetime :cancelled_at

      t.timestamps
    end

    add_index :memberships, :end_date
  end
end
