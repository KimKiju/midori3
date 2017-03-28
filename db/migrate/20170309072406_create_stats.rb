class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.date :date
      t.string :used_korean
      t.string :korean_learning
      t.string :politic_learning
      t.string :roll_calling
      t.string :morning_meeting
      t.string :attendance
      t.string :reviewing
      t.integer :study_time
      t.integer :korean_books
      t.integer :other_books
      t.string :room_cleaning
      t.string :campus_cleaning
      t.integer :user_id
      t.timestamps
    end
  end
end
