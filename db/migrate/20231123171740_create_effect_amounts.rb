class CreateEffectAmounts < ActiveRecord::Migration[7.0]
  def change
    create_table :effect_amounts do |t|
      t.string :kaizen_type
      t.string :unit
      t.integer :amount
      t.boolean :deletion_flag, default: false

      t.timestamps
    end
  end
end
