class CreateAthletes < ActiveRecord::Migration[8.1]
  def change
    create_table :athletes do |t|
      t.string :name, null: false
      t.string :phone
      t.string :line_user_id
      t.date :started_on, null: false
      t.text :notes
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
