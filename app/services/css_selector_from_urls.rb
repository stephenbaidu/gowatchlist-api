class CssSelectorFromUrls < ServiceBase
  def initialize(site_url, item_url)
    @site_url = site_url
    @item_url = item_url
  end

  def call
    first_matching_element&.css_path
  end

  private

  def valid_anchor_elements
    html = PageHtml.call(@site_url)
    ExtractAnchorElements.call(html)
  end

  def first_matching_element
    valid_anchor_elements.find do |element|
      href = element.attr('href')
      uri = URI.parse(href) rescue nil
      uri&.path == item_url_path
    end
  end

  def item_url_path
    @item_url_path ||= URI.parse(@item_url).path
  end
end
