class ShowPdfController < ApplicationController
  def index
    selected_ids = params[:selected_kaizen_reports] || []
    @kaizen_reports = KaizenReport.where(id: selected_ids)

    respond_to do |format|
      format.pdf do
        show_pdf = ShowPdf.new(@kaizen_reports).render
        send_data show_pdf,
          filename: "kaizen_reports.pdf",
          type: 'application/pdf',
          disposition: 'inline' # 外すとアクセス時に自動ダウンロードされるようになる
      end
    end
  end
end