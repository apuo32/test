class CreateKaizenReports < ActiveRecord::Migration[7.0]
  def change
    create_table :kaizen_reports do |t|
      t.references :user, null: false, foreign_key: true
      t.string :subject
      t.date :submission_date
      t.text :before_text
      t.text :after_text
      t.string :before_image
      t.string :after_image
      t.text :effect_comment
      t.integer :cost
      t.integer :effect_amount
      t.references :tsk_value, null: false, foreign_key: true
      t.references :evaluator_progress, null: false, foreign_key: true
      t.string :evaluators_id
      t.text :evaluation_comment
      t.string :kaizen_member_id
      t.references :award, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.datetime :deletion_date
      t.boolean :deletion_flag

      t.timestamps
    end
  end
end
