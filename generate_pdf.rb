require 'prawn'
require 'prawn/table'

font_dir = '/usr/share/fonts/noto'
noto_sans_vf = Dir.glob("#{font_dir}/**/NotoSansCJKjp-VF.ttf").first

Prawn::Document.generate('output/sample.pdf') do
  if noto_sans_vf && File.exist?(noto_sans_vf)
    font_families.update(
      'NotoSansCJKjp' => {
        normal: noto_sans_vf,
        bold: noto_sans_vf,
        italic: noto_sans_vf
      }
    )
    font 'NotoSansCJKjp'
  end

  text '請求書', size: 24, style: :bold, align: :center
  move_down 30

  jst_time = Time.now.getlocal('+09:00')
  text "請求日: #{jst_time.strftime('%Y年%m月%d日')}", size: 12
  move_down 5
  text "請求番号: INV-2025-1008-0001", size: 12
  move_down 30

  text '株式会社サンプル', size: 14, style: :bold
  move_down 5
  text 'ご担当者 様', size: 14, style: :bold
  move_down 30

  bounding_box([bounds.right - 200, cursor], width: 200) do
    text '株式会社サンプル', size: 12, style: :bold
    move_down 5
    text '〒100-8111', size: 12
    move_down 5
    text '東京都千代田区千代田1-1', size: 12
    move_down 5
    text 'TEL: 03-1234-5678', size: 12
    move_down 5
    text 'Email: sample@example.com', size: 12
  end
  move_down 10

  stroke_horizontal_rule
  move_down 10
  text "ご請求金額: ¥550,000 (税込)", size: 16, style: :bold, align: :right
  move_down 10
  stroke_horizontal_rule
  move_down 20

  table_data = [
    ['項目', '数量', '単価', '税込金額'],
    ['Webサイト制作', '1式', '¥300,000', '¥300,000'],
    ['システム開発', '1式', '¥200,000', '¥200,000'],
    ['保守サポート (月額)', '1ヶ月', '¥50,000', '¥50,000']
  ]

  table(table_data, header: true, width: bounds.width, cell_style: { size: 12, padding: 8 }) do
    row(0).font_style = :bold
    row(0).background_color = 'EEEEEE'
    columns(0).align = :left
    columns(1..3).align = :right
  end
  move_down 20

  bounding_box([bounds.right - 250, cursor], width: 250) do
    text "小計: ¥550,000", size: 12, align: :right
    move_down 5
    text "内消費税 (10%): ¥50,000", size: 12, align: :right
    move_down 5
    stroke_horizontal_rule
    move_down 5
    text "合計: ¥550,000", size: 12, style: :bold, align: :right
  end
  move_down 40

  text '【お振込先】', size: 12, style: :bold
  move_down 5
  text 'サンプル銀行 本店', size: 12
  move_down 5
  text '普通預金 1234567', size: 12
  move_down 5
  text '口座名義: カ)サンプル', size: 12
  move_down 10
  text '※お振込手数料はお客様負担でお願いいたします。', size: 10
  move_down 20

  text "発行日時: #{jst_time.strftime('%Y-%m-%d %H:%M:%S')}", size: 10, align: :right
end

puts 'PDF generated successfully: output/sample.pdf'
