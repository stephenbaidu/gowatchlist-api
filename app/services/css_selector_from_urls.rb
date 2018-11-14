require 'watir'

class CssSelectorFromUrls < ServiceBase
  attr_reader :site_url, :item_url, :css_selector

  def initialize(site_url, item_url)
    @site_url = site_url
    @item_url = item_url
  end

  def call
    browser.goto site_url
    @css_selector = first_matching_element&.css_path
    browser.close

    css_selector
  end

  private

  def valid_anchor_elements
    @valid_anchor_elements ||= document.xpath('.//a').select do |element|
      element.attr('href').present?
    end
  end

  def href_of(element)
    element.attr('href')
  end

  def first_matching_element
    @first_matching_element ||= valid_anchor_elements.find do |element|
      href = element.attr('href')
      URI.parse(href).path == item_url_path
    end
  end

  def item_url_path
    @item_url_path ||= URI.parse(item_url).path
  end

  def browser
    @browser ||= begin
      options = SeleniumWebDriverChromeOptions.call
      Watir::Browser.new :chrome, options: options
    end
  end

  def document
    Nokogiri::HTML(browser.html)
  end
end
