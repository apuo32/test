require 'roo'

class Admin::CalendarsController < ApplicationController
  before_action :check_admin # 管理者かどうかチェック  # 管理者であればこのコントローラーにアクセス可能

  def index
    @calendars = Calendar.all.order(time: "ASC") # time(回)の昇順で表示
  end

  def new
    @calendar = Calendar.new # Calendarモデルのインスタンス作成
  end

  def create
    @calendar = Calendar.new(calendar_params)
    if @calendar.save
      redirect_to admin_calendars_path
    else
      @errors = @calendar.errors.full_messages
      render :new, status: :unprocessable_entity
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
      @errors = @calendar.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @calendar = Calendar.find(params[:id])
    if @calendar.destroy
      redirect_to admin_calendars_path, notice: "カレンダーを削除しました。"
    else
      redirect_to admin_calendars_path, alert: "カレンダーの削除に失敗しました。"
    end
  end
  

  def import
    if params[:file].present?
      file = params[:file]
      spreadsheet = Roo::Spreadsheet.open(file.path)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        calendar = Calendar.new
        calendar.term = row["term"]
        calendar.time = row["time"]
        calendar.first_evaluation_submission_date = row["first_evaluation_submission_date"]
        calendar.second_evaluation_submission_date = row["second_evaluation_submission_date"]
        calendar.award_date = row["award_date"]
        calendar.save
      end
      redirect_to admin_calendars_path, notice: "Calendars imported."
    else
      redirect_to new_admin_calendar_path, alert: "Please upload a file."
    end
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
