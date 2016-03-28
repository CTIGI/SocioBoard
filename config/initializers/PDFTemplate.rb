class PDFTemplate
  include Prawn
  require "prawn/measurement_extensions"

  @@font_size = {
    very_small: 8,
    small: 22
  }

  def initialize(pdf)
    @pdf = pdf
  end

  def header(report_name)
    @pdf.image "#{Rails.root}/app/assets/images/socioboard.png", width: 120, at: [0,530]
    @pdf.text report_name, align: :center, size: @@font_size[:small]
    @pdf.text Time.now.strftime('%d/%m/%Y às %H:%M'), align: :center, size: @@font_size[:very_small]
    @pdf.image "#{Rails.root}/app/assets/images/vicegov.png", width: 220, at: [580,525]
    @pdf.stroke_horizontal_line 0, 780, at: 480, align: :center
  end
end
