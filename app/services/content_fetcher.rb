require 'watir'
require 'fileutils'

class ContentFetcher < ServiceBase
  attr_reader :url, :css_selector, :content

  def initialize(url, css_selector)
    @url = url
    @css_selector = css_selector
  end

  def call
    browser.goto url

    @content =
      document
        .search(css_selector)
        .map { |e| e.attr('href') || e.content }
    browser.close

    content
  end

  private

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
