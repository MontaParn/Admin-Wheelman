class CreatePackagePlans < ActiveRecord::Migration[8.1]
  def change
    create_table :package_plans do |t|
      t.string :name, null: false
      t.boolean :run, null: false, default: false
      t.boolean :swim, null: false, default: false
      t.boolean :bike, null: false, default: false
      t.integer :billing_cycle, null: false
      t.integer :duration_days, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
