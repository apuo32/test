class Admin::EvaluatorsController < ApplicationController
  def index
    @evaluators = Evaluator.all.order(id: "ASC") # idの昇順で表示
  end

  def new
    @evaluator = Evaluator.new # Evaluatorモデルのインスタンス作成
  end

  def create
    @evaluator = Evaluator.new(evaluator_params)
    if @evaluator.save
      redirect_to admin_evaluators_path
    else
      render :new
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
      render :edit
    end
  end

  def show
  end

    private
    # Strong Parameters
    def evaluator_params
      params.require(:evaluator).permit(:status, :deletion_flag)
    end
end
