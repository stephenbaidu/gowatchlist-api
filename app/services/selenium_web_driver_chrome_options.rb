class SeleniumWebDriverChromeOptions < ServiceBase
  def call
    options = Selenium::WebDriver::Chrome::Options.new

    user_data_dir = "--user-data-dir=#{chrome_dir}"
    options.add_argument user_data_dir

    if (chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil))
      options.binary = chrome_bin
    end

    options.add_argument 'headless'
    options.add_argument 'disable-gpu'

    options
  end

  private

  def chrome_dir
    @chrome_dir ||= begin
      dir = File.join Dir.pwd, %w(tmp chrome)
      FileUtils.mkdir_p dir
      dir
    end
  end
end
