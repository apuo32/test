class UsersController < ApplicationController
  def index
    # params[:q]に検索条件を入れて、その条件を満たすログイン中のユーザーのkaizen_reportsテーブルの全データをkaizen_reports_searchに入れる
    @kaizen_reports_search = KaizenReport.where(evaluator_progress_id: 4).ransack(params[:q])

    # ransackのresultメソッドで@kaizen_reports_search内のデータをviewに表示できる形に変更
    @kaizen_reports_result = @kaizen_reports_search.result.page(params[:page]).per(10)
  end

  def show
    # params[:q]に検索条件を入れて、その条件を満たすログイン中のユーザーのkaizen_reportsテーブルの全データをkaizen_reports_searchに入れる
    @kaizen_reports_search = KaizenReport.where(user_id: current_user.id).ransack(params[:q])

    # ransackのresultメソッドで@kaizen_reports_search内のデータをviewに表示できる形に変更
    @kaizen_reports_result = @kaizen_reports_search.result.page(params[:page]).per(10)

    @calendars = Calendar.all.page(params[:page]).per(10)
  end
end
