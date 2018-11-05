require 'rails_helper'

describe 'DELETE /api/signin' do
  let(:user) { create :user }
  let(:headers) { authenticated_header(user) }
  let(:request) do
    delete '/api/signin', params: {}, headers: headers
  end

  it_behaves_like 'authenticated'

  context 'when params are valid' do
    before { request }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to be_empty }
  end
end
