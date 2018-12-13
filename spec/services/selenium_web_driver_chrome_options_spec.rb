require 'rails_helper'

RSpec.describe SeleniumWebDriverChromeOptions do
  let!(:options) { SeleniumWebDriverChromeOptions.call }

  it 'returns a Selenium::WebDriver::Chrome::Options' do
    expect(options.class).to eq(Selenium::WebDriver::Chrome::Options)
  end

  context 'args' do
    let(:args) { options.args }

    it 'sets user_dir' do
      expect(args.first).to match(/--user-data-dir=.*\/tmp\/chrome/)
    end

    it 'includes headless in args' do
      expect(args).to include('headless')
    end

    it 'includes disable-gpu in args' do
      expect(args).to include('disable-gpu')
    end
  end
end
