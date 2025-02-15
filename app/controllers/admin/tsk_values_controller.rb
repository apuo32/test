class Admin::TskValuesController < ApplicationController
  before_action :check_admin # 管理者かどうかチェック  # 管理者であればこのコントローラーにアクセス可能

  def index
    if params[:q].blank?
      params[:q] = { deletion_flag_eq: 'false' }
    end

    @tsk_values_search = TskValue.all.order(id: "ASC").ransack(params[:q]) # idの昇順で表示
    @tsk_values_search_result = @tsk_values_search.result
  end

  def new
    @tsk_value = TskValue.new # TskValueモデルのインスタンス作成
  end

  def create
    @tsk_value = TskValue.new(tsk_value_params)
    if @tsk_value.save
      redirect_to admin_tsk_values_path
    else
      @errors = @tsk_value.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @tsk_value = TskValue.find(params[:id])
  end

  def update
    @tsk_value = TskValue.find(params[:id])
    if @tsk_value.update(tsk_value_params)
      # 削除フラグが true に設定されている場合、削除日を更新日時に設定
      if @tsk_value.deletion_flag
        @tsk_value.update(deletion_date: @tsk_value.updated_at)
      end
      redirect_to admin_tsk_values_path
    else
      @errors = @tsk_value.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

    private
    # Strong Parameters
    def tsk_value_params
      params.require(:tsk_value).permit(:value_name, :deletion_flag)
    end

    # ログイン中のuserのadmin_flagがfalseであればルートパスにリダイレクト
    def check_admin
      redirect_to root_path, alert: '管理者権限が必要です' unless current_user.admin_flag?
    end
end
