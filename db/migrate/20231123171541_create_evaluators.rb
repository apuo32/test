class CreateEvaluators < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluators do |t|
      t.string :status
      t.datetime :deletion_date
      t.boolean :deletion_flag, default: false

      t.timestamps
    end
  end
end
