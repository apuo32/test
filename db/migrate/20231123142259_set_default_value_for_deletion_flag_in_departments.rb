class SetDefaultValueForDeletionFlagInDepartments < ActiveRecord::Migration[7.0]
  def change
    change_column_default :departments, :deletion_flag, from: nil, to: false
  end
end
