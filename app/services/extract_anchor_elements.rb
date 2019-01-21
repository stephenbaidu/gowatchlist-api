class ExtractAnchorElements < ServiceBase
  def initialize(html)
    @html = html
  end

  def call
    @html
      .xpath('.//a')
      .select { |element| element.attr('href').present? }
  end
end
