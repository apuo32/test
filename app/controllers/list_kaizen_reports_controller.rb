require 'csv'

class ListKaizenReportsController < ApplicationController
  def index
    @search_params = search_params
    # params[:q]に検索条件を入れて、その条件を満たすログイン中のユーザーのkaizen_reportsテーブルの全データをkaizen_reports_searchに入れる
    @kaizen_reports_search = KaizenReport.where(evaluator_progress_id: 4).ransack(@search_params)

    # ransackのresultメソッドで@kaizen_reports_search内のデータをviewに表示できる形に変更
    @kaizen_reports_result = @kaizen_reports_search.result.page(params[:page]).per(10)
  end

  def show
    @kaizen_report = KaizenReport.find(params[:id])

    @users = User.where(deletion_flag: false).order(id: "ASC")
    @tsk_values = TskValue.where(deletion_flag: false)
    @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
    @awards = Award.where(deletion_flag: false)
    @evaluator_progresses = EvaluatorProgress.where(deletion_flag: false)
  end

  def export_csv
    # 現在の検索クエリに基づくレポートを取得
    search_query = KaizenReport.ransack(params[:q])
    kaizen_reports = search_query.result.includes(:award, :evaluator_progress)
                                        .where(evaluator_progress_id: 4)

    # CSVデータの生成と送信
    respond_to do |format|
      format.csv { send_data generate_csv(kaizen_reports), filename: "kaizen_reports-#{Date.today}.csv" }
    end
  end

  private

  def generate_csv(kaizen_reports)
    CSV.generate(headers: true) do |csv|
      # CSVのヘッダー
      csv << ['submission_date', 'kaizen_report_id', 'employee_code', 'effect_amount', 'award_id']
  
      # 各レポートのデータをCSVに追加
      kaizen_reports.each do |report|
        # kaizen_member_idからメンバーのemployee_codeを取得
        member_ids = JSON.parse(report.kaizen_member_id) # JSONを配列に変換
        members = User.where(id: member_ids)
  
        # 各メンバーごとにCSVに行を追加
        members.each do |member|
          csv << [report.submission_date, report.id, member.employee_code, report.effect_amount, report.award_id]
        end
      end
    end
  end

  def search_params
    params.fetch(:q, {}).permit(:user_username_cont, :award_id_eq, :submission_date_gteq, :submission_date_lteq)
  end
  
end
