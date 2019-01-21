require 'rails_helper'

RSpec.describe ChromeOptions do
  let!(:dir) { File.join(Dir.pwd, %w(tmp chrome)) }
  let!(:options) { ChromeOptions.new(dir, nil) }

  before do
    allow_any_instance_of(CreateChromeUserDataDir).to receive(:call).and_return(dir)
  end

  it 'returns a Selenium::WebDriver::Chrome::Options' do
    expect(options).to be_a_kind_of(Selenium::WebDriver::Chrome::Options)
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
