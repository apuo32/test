class CreateDepartments < ActiveRecord::Migration[7.0]
  def change
    create_table :departments do |t|
      t.string :department_name
      t.datetime :deletion_date
      t.boolean :deletion_flag

      t.timestamps
    end
  end
end
