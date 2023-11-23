class CreateTskValues < ActiveRecord::Migration[7.0]
  def change
    create_table :tsk_values do |t|
      t.string :value_name
      t.datetime :deletion_date
      t.boolean :deletion_flag, default: false

      t.timestamps
    end
  end
end
