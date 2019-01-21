require 'rails_helper'

RSpec.describe CreateChromeUserDataDir do
  let(:dir) { File.join(Dir.pwd, %w(tmp chrome)) }
  let(:service) { CreateChromeUserDataDir.new }

  before do
    FileUtils.rm_rf(dir)
  end

  it 'creates dir' do
    expect { service.call }.to change { File.directory?(dir) }.from(false).to(true)
  end
end
