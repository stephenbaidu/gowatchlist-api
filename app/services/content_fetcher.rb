class ContentFetcher < ServiceBase
  def initialize(url, css_selector)
    @url = url
    @css_selector = css_selector
  end

  def call
    elements.map { |element| element.attr('href') || element.content }
  end

  private

  def elements
    document = PageHtml.call(@url)
    document.search(@css_selector)
  end
end
