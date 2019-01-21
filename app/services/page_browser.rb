require 'watir'

class PageBrowser < Watir::Browser
  def initialize
    data_dir = CreateChromeUserDataDir.call
    chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
    options = ChromeOptions.new(data_dir, chrome_bin)
    super :chrome, options: options
  end
end
