class RenameAndAddCommentsToKaizenReports < ActiveRecord::Migration[7.0]
  def change
    rename_column :kaizen_reports, :evaluation_comment, :first_evaluator_comment
    add_column :kaizen_reports, :second_evaluator_comment, :text
    add_column :kaizen_reports, :final_evaluator_comment, :text
  end
end
