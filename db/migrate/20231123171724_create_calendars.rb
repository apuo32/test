class CreateCalendars < ActiveRecord::Migration[7.0]
  def change
    create_table :calendars do |t|
      t.integer :term
      t.integer :time
      t.date :first_evaluation_submission_date
      t.date :second_evaluation_submission_date
      t.date :award_date

      t.timestamps
    end
  end
end
