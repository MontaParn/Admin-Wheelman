class CreateEventAttendances < ActiveRecord::Migration[8.1]
  def change
    create_table :event_attendances do |t|
      t.references :event, null: false, foreign_key: true
      t.references :athlete, null: false, foreign_key: true

      t.timestamps
    end

    add_index :event_attendances, %i[event_id athlete_id], unique: true
  end
end
