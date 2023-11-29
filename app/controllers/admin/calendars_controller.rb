class Admin::CalendarsController < ApplicationController
  before_action :check_admin # 管理者かどうかチェック  # 管理者であればこのコントローラーにアクセス可能

  def index
    @calendars = Calendar.all.order(id: "ASC") # idの昇順で表示
  end

  def new
    @calendar = Calendar.new # Calendarモデルのインスタンス作成
  end

  def create
    @calendar = Calendar.new(calendar_params)
    if @calendar.save
      redirect_to admin_calendars_path
    else
      render :new
    end
  end

  def edit
    @calendar = Calendar.find(params[:id])
  end

  def update
    @calendar = Calendar.find(params[:id])
    if @calendar.update(calendar_params)
      redirect_to admin_calendars_path
    else
      render :edit
    end
  end

  def show
  end

    private
    # Strong Parameters
    def calendar_params
      params.require(:calendar).permit(:term, :time, :first_evaluation_submission_date, :second_evaluation_submission_date, :award_date)
    end

    # ログイン中のuserのadmin_flagがfalseであればルートパスにリダイレクト
    def check_admin
      redirect_to root_path, alert: '管理者権限が必要です' unless current_user.admin_flag?
    end
end
