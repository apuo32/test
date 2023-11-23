class Admin::CalendarsController < ApplicationController
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
end
