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

  text 'こんにちは、Prawn!', size: 30, style: :bold

  move_down 20
  text 'これは日本語に対応したPrawnのサンプルアプリケーションです。'

  move_down 20
  text 'PrawnとNoto Sans JPフォントを使用してPDFを簡単に生成できます。', size: 12

  move_down 30
  stroke_horizontal_rule

  move_down 20
  jst_time = Time.now.getlocal('+09:00')
  text "生成日時: #{jst_time.strftime('%Y-%m-%d %H:%M:%S')}", size: 10, style: :italic
end

puts 'PDF generated successfully: output/sample.pdf'
