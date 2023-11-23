class CreateEvaluatorProgresses < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluator_progresses do |t|
      t.string :status
      t.boolean :deletion_flag, default: false

      t.timestamps
    end
  end
end
