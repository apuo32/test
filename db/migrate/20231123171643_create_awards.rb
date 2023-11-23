class CreateAwards < ActiveRecord::Migration[7.0]
  def change
    create_table :awards do |t|
      t.string :award_name
      t.datetime :deletion_date
      t.boolean :deletion_flag, default: false

      t.timestamps
    end
  end
end
