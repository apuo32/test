class Admin::EvaluatorsController < ApplicationController
  before_action :check_admin # 管理者かどうかチェック  # 管理者であればこのコントローラーにアクセス可能

  def index
    if params[:q].blank?
      params[:q] = { deletion_flag_eq: 'false' }
    end

    @evaluators_search = Evaluator.all.order(id: "ASC").ransack(params[:q]) # idの昇順で表示
    @evaluators_search_result = @evaluators_search.result
  end

  def new
    @evaluator = Evaluator.new # Evaluatorモデルのインスタンス作成
  end

  def create
    @evaluator = Evaluator.new(evaluator_params)
    if @evaluator.save
      redirect_to admin_evaluators_path
    else
      @errors = @evaluator.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @evaluator = Evaluator.find(params[:id])
  end

  def update
    @evaluator = Evaluator.find(params[:id])
    if @evaluator.update(evaluator_params)
      # 削除フラグが true に設定されている場合、削除日を更新日時に設定
      if @evaluator.deletion_flag
        @evaluator.update(deletion_date: @evaluator.updated_at)
      end
      redirect_to admin_evaluators_path
    else
      @errors = @evaluator.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

    private
    # Strong Parameters
    def evaluator_params
      params.require(:evaluator).permit(:status, :deletion_flag)
    end

    # ログイン中のuserのadmin_flagがfalseであればルートパスにリダイレクト
    def check_admin
      redirect_to root_path, alert: '管理者権限が必要です' unless current_user.admin_flag?
    end
end
