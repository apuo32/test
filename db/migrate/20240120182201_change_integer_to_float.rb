class ChangeIntegerToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :kaizen_reports, :cost, :float
    change_column :kaizen_reports, :effect_amount, :float
    # 任意のテーブルの 'amount' カラムを変更する場合
    change_column :effect_amounts, :amount, :float
  end
end
