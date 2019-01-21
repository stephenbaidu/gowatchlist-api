class ChromeOptions < Selenium::WebDriver::Chrome::Options
  def initialize(data_dir, chrome_bin)
    @data_dir = data_dir
    @chrome_bin = chrome_bin
    super default_options
  end

  private

  def user_data_dir
    "--user-data-dir=#{@data_dir}"
  end

  def default_options
    {
      args: [user_data_dir, 'headless', 'disable-gpu'],
      binary: @chrome_bin
    }
  end
end
