class CreateReminders < ActiveRecord::Migration[8.1]
  def change
    create_table :reminders do |t|
      t.references :membership, null: false, foreign_key: true
      t.integer :channel, null: false, default: 0
      t.text :message_body, null: false
      t.datetime :sent_at
      t.integer :status, null: false

      t.timestamps
    end
  end
end
