class KaizenReportsController < ApplicationController
  def new
    @kaizen_report = KaizenReport.new # KaizenReportモデルのインスタンス作成
    @users = User.where(deletion_flag: false).order(id: "ASC")
    
    
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
        redirect_to root_path 
      else
        # 後からまとめる
        @users = User.where(deletion_flag: false).order(id: "ASC")
        @tsk_values = TskValue.all
        @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
        @awards = Award.all
        @evaluator_progresses = EvaluatorProgress.all
        # 後からまとめる

        @errors = @kaizen_report.errors.full_messages

        render :new, status: :unprocessable_entity
      end
    # 提出ボタン(name: "submit")を押した場合
    else
      if  @kaizen_report.update(submission_flag: true)
        redirect_to root_path
      else
        # 後からまとめる
        @users = User.where(deletion_flag: false).order(id: "ASC")
        @tsk_values = TskValue.all
        @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
        @awards = Award.all
        @evaluator_progresses = EvaluatorProgress.all
        # 後からまとめる

        @errors = @kaizen_report.errors.full_messages

        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    @kaizen_report = KaizenReport.find(params[:id])
    @users = User.where(deletion_flag: false).order(id: "ASC")

    # 後からまとめる
    @tsk_values = TskValue.all
    @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
    @awards = Award.all
    @evaluator_progresses = EvaluatorProgress.all
    # 後からまとめる
  end

  def update
    @kaizen_report = KaizenReport.find(params[:id])

    # フォームから送信された画像データを取得し、空の文字列を除外する
    before_images_data = params[:kaizen_report][:before_images].reject(&:blank?)
    after_images_data = params[:kaizen_report][:after_images].reject(&:blank?)

    # 画像パラメータを条件に応じて更新用パラメータに含めるか決定
    update_params = kaizen_report_params.dup # ストロングパラメータのコピーを作成
    update_params = update_params.except(:before_images) if before_images_data.empty?
    update_params = update_params.except(:after_images) if after_images_data.empty?
  
    # 保存ボタン(name: "save")を押した場合
    if params[:save]
      if @kaizen_report.update(update_params)
        # 更新に成功した場合、マイページにリダイレクト
        redirect_to root_path, notice: '改善報告が更新されました。'
      else
        # 後からまとめる
        @users = User.where(deletion_flag: false).order(id: "ASC")
        @tsk_values = TskValue.all
        @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
        @awards = Award.all
        @evaluator_progresses = EvaluatorProgress.all
        # 後からまとめる

        @errors = @kaizen_report.errors.full_messages

        # 更新に失敗した場合、編集画面に戻る
        render :edit, status: :unprocessable_entity
      end
    # 提出ボタン(name: "submit")を押した場合
    else
      # 提出ボタンが押された場合、submission_flagをtrueに設定
      update_params = update_params.merge(submission_flag: true, evaluator_progress_id: 1)

      if @kaizen_report.update(update_params)
        # 更新に成功した場合、マイページにリダイレクト
        redirect_to root_path, notice: '改善報告が提出されました。'
      else
        # 後からまとめる
        @users = User.where(deletion_flag: false).order(id: "ASC")
        @tsk_values = TskValue.all
        @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
        @awards = Award.all
        @evaluator_progresses = EvaluatorProgress.all
        # 後からまとめる

        @errors = @kaizen_report.errors.full_messages

        # 更新に失敗した場合、編集画面に戻る
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @kaizen_report = KaizenReport.find(params[:id])
    @kaizen_report.destroy
    redirect_to user_path(current_user), notice: '改善報告を削除しました'
  end

  def show
    @kaizen_report = KaizenReport.find(params[:id])
    @users = User.where(deletion_flag: false).order(id: "ASC")

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
        :submission_date,
        :subject, 
        :before_text, 
        :after_text,  
        :effect_comment,
        :cost,
        :effect_amount,
        :tsk_value_id,        
        :evaluator_progress_id,
        :department_id,
        :award_id,
        :evaluator_id,
        :submission_flag,
        before_images: [],
        after_images: [],
        kaizen_member_id: []
        )
    end
end
