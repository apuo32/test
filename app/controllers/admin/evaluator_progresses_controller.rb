class Admin::EvaluatorProgressesController < ApplicationController
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
end
