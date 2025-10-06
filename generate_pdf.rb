require 'prawn'

Prawn::Document.generate('output/sample.pdf') do
  text 'Hello, Prawn!', size: 30, style: :bold

  move_down 20
  text 'This is a minimal Prawn sample application.'

  move_down 20
  text 'Prawn makes it easy to generate PDFs with Ruby.', size: 12

  move_down 30
  stroke_horizontal_rule

  move_down 20
  text "Generated at: #{Time.now}", size: 10, style: :italic
end

puts 'PDF generated successfully: output/sample.pdf'
