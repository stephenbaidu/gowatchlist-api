class ContentFetcher < ServiceBase
  def initialize(url, css_selector)
    @url = url
    @css_selector = css_selector
  end

  def call
    elements.map { |element| ElementValue.call(element) }
  end

  private

  def elements
    document = PageHtml.call(@url)
    document.search(@css_selector)
  end
end
