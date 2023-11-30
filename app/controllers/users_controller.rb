class UsersController < ApplicationController
  def index
    @kaizen_reports = KaizenReport.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  def new
    @kaizen_report = KaizenReport.new # KaizenReportモデルのインスタンス作成
    @current_user = current_user
    @tsk_values = TskValue.all
    @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
    @awards = Award.all
    @evaluator_progresses = EvaluatorProgress.all
  end

  def create
    @kaizen_report = KaizenReport.new(kaizen_report_params)
    @kaizen_report.user_id = current_user.id
    @kaizen_report.department_id = current_user.department.id
    if @kaizen_report.save
      redirect_to users_path
    else
      @current_user = current_user
      @tsk_values = TskValue.all
      @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
      @awards = Award.all
      @evaluator_progresses = EvaluatorProgress.all
      render :new
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
