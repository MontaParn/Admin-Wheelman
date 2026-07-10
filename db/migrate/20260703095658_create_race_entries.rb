class CreateRaceEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :race_entries do |t|
      t.references :athlete, null: false, foreign_key: true
      t.string :race_name, null: false
      t.date :race_date, null: false
      t.string :discipline
      t.string :result

      t.timestamps
    end
  end
end
