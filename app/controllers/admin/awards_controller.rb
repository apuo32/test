class Admin::AwardsController < ApplicationController
  def index
    @awards = Award.all.order(id: "ASC") # idの昇順で表示
  end

  def new
    @award = Award.new # Awardモデルのインスタンス作成
  end

  def create
    @award = Award.new(award_params)
    if @award.save
      redirect_to admin_awards_path
    else
      render :new
    end
  end

  def edit
    @award = Award.find(params[:id])
  end

  def update
    @award = Award.find(params[:id])
    if @award.update(award_params)
      # 削除フラグが true に設定されている場合、削除日を更新日時に設定
      if @award.deletion_flag
        @award.update(deletion_date: @award.updated_at)
      end
      redirect_to admin_awards_path
    else
      render :edit
    end
  end

  def show
  end

    private
    # Strong Parameters
    def award_params
      params.require(:award).permit(:award_name, :deletion_flag)
    end
end
