class Admin::EffectAmountsController < ApplicationController
  def index
    @effect_amounts = EffectAmount.all.order(id: "ASC") # idの昇順で表示
  end

  def new
    @effect_amount = EffectAmount.new # EffectAmountモデルのインスタンス作成
  end

  def create
    @effect_amount = EffectAmount.new(effect_amount_params)
    if @effect_amount.save
      redirect_to admin_effect_amounts_path
    else
      render :new
    end
  end

  def edit
    @effect_amount = EffectAmount.find(params[:id])
  end

  def update
    @effect_amount = EffectAmount.find(params[:id])
    if @effect_amount.update(effect_amount_params)
      redirect_to admin_effect_amounts_path
    else
      render :edit
    end
  end

  def show
  end

    private
    # Strong Parameters
    def effect_amount_params
      params.require(:effect_amount).permit(:kaizen_type, :unit, :amount, :deletion_flag)
    end
end
