class EvaluatorsController < ApplicationController
  before_action :check_evaluator # 評価者かどうかチェック  # 評価者であればこのコントローラーにアクセス可能

  def show

    # 未評価
    # params[:q]に検索条件を入れて、その条件を満たすログイン中のユーザーのkaizen_reportsテーブルの全データをkaizen_reports_searchに入れる
    @non_evaluation_kaizen_reports_search = KaizenReport.joins(:user)
                                         .where(submission_flag: true)
                                         .where(evaluator_progress_id: 1)
                                         .where("users.first_evaluator_id = ? OR users.second_evaluator_id = ?", current_user.id, current_user.id)
                                         .ransack(params[:q])

    # ransackのresultメソッドで@kaizen_reports_search内のデータをviewに表示できる形に変更
    @non_evaluation_kaizen_reports_result = @non_evaluation_kaizen_reports_search.result.page(params[:page]).per(10)

    # 1次評価済み
    # params[:q]に検索条件を入れて、その条件を満たすログイン中のユーザーのkaizen_reportsテーブルの全データをkaizen_reports_searchに入れる
    @first_evaluation_kaizen_reports_search = KaizenReport.joins(:user)
                                         .where(submission_flag: true)
                                         .where(evaluator_progress_id: 2)
                                         .where("users.first_evaluator_id = ? OR users.second_evaluator_id = ?", current_user.id, current_user.id)
                                         .ransack(params[:q])

    # ransackのresultメソッドで@kaizen_reports_search内のデータをviewに表示できる形に変更
    @first_evaluation_kaizen_reports_result = @first_evaluation_kaizen_reports_search.result.page(params[:page]).per(10)

    # 2次評価済み
    # params[:q]に検索条件を入れて、その条件を満たすログイン中のユーザーのkaizen_reportsテーブルの全データをkaizen_reports_searchに入れる
    @second_evaluation_kaizen_reports_search = KaizenReport.joins(:user)
                                         .where(submission_flag: true)
                                         .where(evaluator_progress_id: 3)
                                         .ransack(params[:q])

    # ransackのresultメソッドで@kaizen_reports_search内のデータをviewに表示できる形に変更
    @second_evaluation_kaizen_reports_result = @second_evaluation_kaizen_reports_search.result.page(params[:page]).per(10)

    @calendars = Calendar.all.order(time: "ASC")
  end

  # ログイン中のuserのevaluators_idが4であればルートパスにリダイレクト
  def check_evaluator
    redirect_to root_path, alert: '評価者権限が必要です' if current_user.evaluator_id == 4
  end
end
