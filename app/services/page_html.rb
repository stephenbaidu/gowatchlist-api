class PageHtml < ServiceBase
  def initialize(url)
    @url = url
    @browser = CreateBrowser.call
  end

  def call
    @browser.goto @url
    html = Nokogiri::HTML(@browser.html)
    html
  ensure
    @browser.close
  end
end
