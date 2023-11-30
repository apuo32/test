class AddSubmissionFlagToKaizenReports < ActiveRecord::Migration[7.0]
  def change
    add_column :kaizen_reports, :submission_flag, :boolean, default: false
  end
end
