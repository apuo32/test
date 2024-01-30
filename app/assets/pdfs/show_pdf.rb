require 'open-uri'

class ShowPdf < Prawn::Document
  def initialize(kaizen_reports)
    super(page_size: 'A4') #A4サイズのPDFを新規作成
    # stroke_axis # 座標を表示（これがあると便利）
    @kaizen_reports = kaizen_reports

    # ↓追記（日本語フォントの読み込み）
    font_families.update('JP' => { 
                            normal: 'app/assets/fonts/ipaexm.ttf', 
                            bold: 'app/assets/fonts/ipaexg.ttf' 
                        })
    font 'JP'

    #-------- ↓ここにコードを記述する ----------
    @kaizen_reports.each do |report|
      create_report_page(report)
      start_new_page unless report == @kaizen_reports.last
    end
  end

  private

  require 'open-uri'
  def create_report_page(report)
    text "社員CD: #{report.user.employee_code}", size: 12
    text "部署: #{report.user.department.department_name}", size: 12
    text "氏名: #{report.user.username}", size: 12
    text "提出日: #{report.submission_date}", size: 12
    text "件名: #{report.subject}", size: 12

    # 改善前の画像を表示
    if report.before_images.attached?
      report.before_images.each do |image|
        image_path = download_image(image)
        image(image_path, width: 300, height: 200) if image_path
        move_down 10
      end
    end

    text "改善前のテキスト: #{report.before_text}", size: 12

    # 改善後の画像を表示
    if report.after_images.attached?
      report.after_images.each do |image|
        image_path = download_image(image)
        image(image_path, width: 300, height: 200) if image_path
        move_down 10
      end
    end

    text "改善後のテキスト: #{report.after_text}", size: 12

    text "効果コメント: #{report.effect_comment}", size: 12
    text "費用: #{report.cost}", size: 12
    text "効果金額: #{report.effect_amount}", size: 12
    text "TSKバリュー: #{report.tsk_value.value_name}", size: 12

    # KAIZENメンバー
    # JSON.parse を使って文字列を配列に変換し、その各要素を整数に変換
    member_ids = JSON.parse(report.kaizen_member_id).map(&:to_i)
    member_usernames = User.where(id: member_ids).pluck(:username)

    text "KAIZENメンバー: #{member_usernames.join(', ')}", size: 12

    text "評価状況: #{report.evaluator_progress.status}", size: 12
    text "賞: #{report.award.award_name}", size: 12
  end

  def download_image(image)
    image_blob = image.blob
    uri = image_blob.service_url(expires_in: 1.minute, disposition: 'inline') # 有効期限付きのURLを生成
    download = open(uri) # 画像をダウンロード
    IO.copy_stream(download, "#{Rails.root}/tmp/#{image.filename}") # 一時ファイルに保存
    "#{Rails.root}/tmp/#{image.filename}" # 一時ファイルのパスを返す
  rescue => e
    Rails.logger.error "Failed to download image: #{e.message}"
    nil
  end
end