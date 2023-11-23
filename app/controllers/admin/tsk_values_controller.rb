class Admin::TskValuesController < ApplicationController
  def index
    @tsk_values = TskValue.all.order(id: "ASC") # idの昇順で表示
  end

  def new
    @tsk_value = TskValue.new # TskValueモデルのインスタンス作成
  end

  def create
    @tsk_value = TskValue.new(tsk_value_params)
    if @tsk_value.save
      redirect_to admin_tsk_values_path
    else
      render :new
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
      render :edit
    end
  end

  def show
  end

    private
    # Strong Parameters
    def tsk_value_params
      params.require(:tsk_value).permit(:value_name, :deletion_flag)
    end
end
