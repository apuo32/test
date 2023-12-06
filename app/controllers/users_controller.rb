class UsersController < ApplicationController
  def index
    # params[:q]に検索条件を入れて、その条件を満たすログイン中のユーザーのkaizen_reportsテーブルの全データをkaizen_reports_searchに入れる
    @kaizen_reports_search = KaizenReport.where(user_id: current_user.id).ransack(params[:q])

    # ransackのresultメソッドで@kaizen_reports_search内のデータをviewに表示できる形に変更
    @kaizen_reports_result = @kaizen_reports_search.result.page(params[:page]).per(10)

    @calendars = Calendar.all.page(params[:page]).per(10)
  end

  def new
    @kaizen_report = KaizenReport.new # KaizenReportモデルのインスタンス作成
    @users = User.all
    
    # 後からまとめる
    @tsk_values = TskValue.all
    @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
    @awards = Award.all
    @evaluator_progresses = EvaluatorProgress.all
    # 後からまとめる
  end

  def create
    @kaizen_report = KaizenReport.new(kaizen_report_params)
    @kaizen_report.user_id = current_user.id
    @kaizen_report.department_id = current_user.department.id

    # 保存ボタン(name: "save")を押した場合
    if params[:save]
      if @kaizen_report.save
        redirect_to users_path
      else
        # 後からまとめる
        @tsk_values = TskValue.all
        @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
        @awards = Award.all
        @evaluator_progresses = EvaluatorProgress.all
        # 後からまとめる

        render :new
      end
    # 提出ボタン(name: "submit")を押した場合
    else
      if  @kaizen_report.update(submission_flag: true)
        redirect_to users_path
      else
        # 後からまとめる
        @tsk_values = TskValue.all
        @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
        @awards = Award.all
        @evaluator_progresses = EvaluatorProgress.all
        # 後からまとめる

        render :new
      end
    end
  end

  def edit
  end

  def show
  end

  private
    # Strong Parameters
    def kaizen_report_params
      params.require(:kaizen_report).permit(
        :submission_date,
        :subject, 
        :before_image,
        :before_text, 
        :after_image,
        :after_text,  
        :effect_comment,
        :cost,
        :effect_amount,
        :tsk_value_id,        
        :kaizen_member_id, 
        :evaluator_progress_id,
        :department_id,
        :award_id,
        :evaluator_id,
        :submission_flag)
    end
end
