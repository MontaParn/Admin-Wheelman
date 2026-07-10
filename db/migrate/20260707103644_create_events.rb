class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.integer :category, null: false
      t.boolean :run, null: false, default: false
      t.boolean :swim, null: false, default: false
      t.boolean :bike, null: false, default: false
      t.text :description
      t.string :location
      t.string :google_map_link
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end

    add_index :events, :start_date
  end
end
