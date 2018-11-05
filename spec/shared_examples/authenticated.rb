shared_examples_for 'authenticated' do
  context 'when no headers present' do
    let(:headers) { {} }

    before { request }

    it { expect(response).to have_http_status(:unauthorized) }
  end
end
