class SubmittedKaizenReportsController < ApplicationController
  def edit
    @kaizen_report = KaizenReport.find(params[:id])
    @users = User.all

    # 後からまとめる
    @tsk_values = TskValue.all
    @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
    @awards = Award.all
    @evaluator_progresses = EvaluatorProgress.all
    # 後からまとめる
  end

  def update
    @kaizen_report = KaizenReport.find(params[:id])
  
    if @kaizen_report.update(kaizen_report_params)
      # 更新に成功した場合、マイページにリダイレクト
      redirect_to evaluator_path(current_user.id), notice: '改善報告が提出されました。'
    else
      # 後からまとめる
      @users = User.all
      @tsk_values = TskValue.all
      @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
      @awards = Award.all
      @evaluator_progresses = EvaluatorProgress.all
      # 後からまとめる

      @errors = @kaizen_report.errors.full_messages

      # 更新に失敗した場合、編集画面に戻る
      render :edit
    end
  end

  def return
    @kaizen_report = KaizenReport.find(params[:id])
    if @kaizen_report.update(submission_flag: false, evaluator_progress_id: 5)
      redirect_to evaluator_path(current_user.id), notice: '改善報告が返却されました。'
    else
      redirect_to evaluator_path(current_user.id), alert: '返却に失敗しました。'
    end
  end

  def show
    @kaizen_report = KaizenReport.find(params[:id])
    @users = User.all

    # 後からまとめる
    @tsk_values = TskValue.all
    @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
    @awards = Award.all
    @evaluator_progresses = EvaluatorProgress.all
    # 後からまとめる
  end

  private
    # Strong Parameters
    def kaizen_report_params
      params.require(:kaizen_report).permit(
        :evaluator_progress_id,
        :award_id, 
        :evaluation_comment)
    end
end
