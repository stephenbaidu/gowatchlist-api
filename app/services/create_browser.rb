require 'watir'

class CreateBrowser < ServiceBase
  def call
    Watir::Browser.new(:chrome, options: chrome_options)
  end

  private

  def chrome_options
    ChromeOptions.new(data_dir, chrome_bin)
  end

  def data_dir
    @data_dir ||= CreateChromeUserDataDir.call
  end

  def chrome_bin
    @chrome_bin ||= ENV.fetch('GOOGLE_CHROME_SHIM', nil)
  end
end
