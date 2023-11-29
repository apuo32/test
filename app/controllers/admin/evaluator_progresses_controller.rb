class Admin::EvaluatorProgressesController < ApplicationController
  before_action :check_admin # 管理者かどうかチェック  # 管理者であればこのコントローラーにアクセス可能

  def index
    @evaluator_progresses = EvaluatorProgress.all.order(id: "ASC") # idの昇順で表示
  end

  def new
    @evaluator_progress = EvaluatorProgress.new # EvaluatorProgressモデルのインスタンス作成
  end

  def create
    @evaluator_progress = EvaluatorProgress.new(evaluator_progress_params)
    if @evaluator_progress.save
      redirect_to admin_evaluator_progresses_path
    else
      render :new
    end
  end

  def edit
    @evaluator_progress = EvaluatorProgress.find(params[:id])
  end

  def update
    @evaluator_progress = EvaluatorProgress.find(params[:id])
    if @evaluator_progress.update(evaluator_progress_params)
      redirect_to admin_evaluator_progresses_path
    else
      render :edit
    end
  end

  def show
  end

    private
    # Strong Parameters
    def evaluator_progress_params
      params.require(:evaluator_progress).permit(:status, :deletion_flag)
    end

    # ログイン中のuserのadmin_flagがfalseであればルートパスにリダイレクト
    def check_admin
      redirect_to root_path, alert: '管理者権限が必要です' unless current_user.admin_flag?
    end
end
