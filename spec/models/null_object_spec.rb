require 'rails_helper'

RSpec.describe NullObject, type: :model do
  subject { NullObject.instance }

  it 'returns empty string for css_path' do
    expect(subject.css_path).to eq('')
  end

  it 'returns empty string for path' do
    expect(subject.path).to eq('')
  end
end