class Admin::EffectAmountsController < ApplicationController
  before_action :check_admin # 管理者かどうかチェック  # 管理者であればこのコントローラーにアクセス可能

  def index
    if params[:q].blank?
      params[:q] = { deletion_flag_eq: 'false' }
    end

    @effect_amounts_search = EffectAmount.all.order(id: "ASC").ransack(params[:q]) # idの昇順で表示
    @effect_amounts_search_result = @effect_amounts_search.result
  end

  def new
    @effect_amount = EffectAmount.new # EffectAmountモデルのインスタンス作成
  end

  def create
    @effect_amount = EffectAmount.new(effect_amount_params)
    if @effect_amount.save
      redirect_to admin_effect_amounts_path
    else
      @errors = @effect_amount.errors.full_messages
      render :new, status: :unprocessable_entity
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
      @errors = @effect_amount.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

    private
    # Strong Parameters
    def effect_amount_params
      params.require(:effect_amount).permit(:kaizen_type, :unit, :amount, :deletion_flag)
    end

    # ログイン中のuserのadmin_flagがfalseであればルートパスにリダイレクト
    def check_admin
      redirect_to root_path, alert: '管理者権限が必要です' unless current_user.admin_flag?
    end
end
