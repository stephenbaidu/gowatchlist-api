require 'rails_helper'

RSpec.describe AdminAuth do
  let(:email) { 'me@example.com' }
  let(:password) { 'password' }
  let(:service) { AdminAuth.new(email, password) }

  context 'when both email and password are valid' do
    before do
      allow(Rails.application.credentials).to receive(:admin_email).and_return(email)
      allow(Rails.application.credentials).to receive(:admin_password).and_return(password)
    end

    it 'returns true' do
      expect(service.call).to eq(true)
    end
  end

  context 'when email is invalid' do
    before do
      allow(Rails.application.credentials).to receive(:admin_email).and_return('notme@example.com')
      allow(Rails.application.credentials).to receive(:admin_password).and_return(password)
    end

    it 'returns false' do
      expect(service.call).to eq(false)
    end
  end

  context 'when password is invalid' do
    before do
      allow(Rails.application.credentials).to receive(:admin_email).and_return(email)
      allow(Rails.application.credentials).to receive(:admin_password).and_return('InvalidPassword')
    end

    it 'returns false' do
      expect(service.call).to eq(false)
    end
  end
end
