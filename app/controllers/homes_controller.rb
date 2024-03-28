class HomesController < ApplicationController
  def index
    @my_kaizen_reports = KaizenReport.order(created_at: :desc).limit(2)
    @kaizen_reports = KaizenReport.order(created_at: :desc).limit(8)
    @calendars = Calendar.all.order(time: "ASC")
  end
end