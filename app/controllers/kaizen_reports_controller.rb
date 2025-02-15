class KaizenReportsController < ApplicationController
  before_action :set_resources, only: [:new, :create, :edit, :update, :show]

  def new
    @kaizen_report = KaizenReport.new # KaizenReportモデルのインスタンス作成
  end

  def create
    @kaizen_report = KaizenReport.new(kaizen_report_params)
    @kaizen_report.user_id = current_user.id
    @kaizen_report.department_id = current_user.department.id

    # KAIZENメンバーに current_user.id が含まれていない場合は追加
    unless @kaizen_report.kaizen_member_id.include?(current_user.id.to_s)
      @kaizen_report.kaizen_member_id << current_user.id.to_s
    end

    # 保存ボタン(name: "save")を押した場合
    if params[:save]
      if @kaizen_report.save
        redirect_to root_path 
      else
        @errors = @kaizen_report.errors.full_messages
        render :new, status: :unprocessable_entity
      end
    # 提出ボタン(name: "submit")を押した場合
    else
      if  @kaizen_report.update(submission_flag: true)
        redirect_to root_path
      else
        @errors = @kaizen_report.errors.full_messages
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    @kaizen_report = KaizenReport.find(params[:id])
  end

  def update
    @kaizen_report = KaizenReport.find(params[:id])

    # ストロングパラメータでKAIZENメンバーIDの配列を取得し、current_user.idを追加
    kaizen_member_ids = params[:kaizen_report][:kaizen_member_id] || []
    unless kaizen_member_ids.include?(current_user.id.to_s)
      kaizen_member_ids << current_user.id.to_s
    end

    # フォームから送信された画像データを取得
    before_images_data = params.dig(:kaizen_report, :before_images)&.reject(&:blank?)
    after_images_data = params.dig(:kaizen_report, :after_images)&.reject(&:blank?)

    # 更新用パラメータの設定
    update_params = kaizen_report_params.dup
    update_params[:kaizen_member_id] = kaizen_member_ids

    # carousel-itemタグの有無をチェック
    before_images_exist = !@kaizen_report.before_images.empty?
    after_images_exist = !@kaizen_report.after_images.empty?

    # before_imagesの処理
    if before_images_data.present?
      # ファイルがアップロードされている場合は、そのまま保存
      update_params[:before_images] = before_images_data
    else
      # ファイルがアップロードされていない場合、２つに分岐
      if before_images_exist
        @kaizen_report.before_images.purge_later
      else
        update_params = update_params.except(:before_images)
      end
    end

    # before_imagesの処理
    if after_images_data.present?
      # ファイルがアップロードされている場合は、そのまま保存
      update_params[:after_images] = after_images_data
    else
      # ファイルがアップロードされていない場合、２つに分岐
      if after_images_exist
        @kaizen_report.after_images.purge_later
      else
        update_params = update_params.except(:after_images)
      end
    end
  
    # 保存ボタン(name: "save")を押した場合
    if params[:save]
      if @kaizen_report.update(update_params)
        # 更新に成功した場合、マイページにリダイレクト
        redirect_to root_path, notice: '改善報告が更新されました。'
      else
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
  end

  private  
    def set_resources
      @users = User.where(deletion_flag: false).order(id: "ASC")
      @tsk_values = TskValue.where(deletion_flag: false)
      @evaluation_dates = Calendar.pluck(:first_evaluation_submission_date).select { |date| Date.today <= date }.uniq
      @awards = Award.where(deletion_flag: false)
      @evaluator_progresses = EvaluatorProgress.where(deletion_flag: false)
      @effect_amounts = EffectAmount.where(deletion_flag: false).to_a.group_by(&:kaizen_type)
    end

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
