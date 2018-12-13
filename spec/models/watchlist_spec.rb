# == Schema Information
#
# Table name: watchlists
#
#  id         :bigint(8)        not null, primary key
#  active     :boolean          default(FALSE)
#  deleted_at :datetime
#  expires_at :datetime
#  name       :string           not null
#  selector   :string           not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_watchlists_on_name_and_user_id  (name,user_id) UNIQUE WHERE (deleted_at IS NULL)
#  index_watchlists_on_url_and_user_id   (url,user_id) UNIQUE WHERE (deleted_at IS NULL)
#  index_watchlists_on_user_id           (user_id)
#

require 'rails_helper'

RSpec.describe Watchlist, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_one(:visit_info) }
  end

  describe 'validations' do
    let(:subject) { create :watchlist }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:selector) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive }
    it { should validate_uniqueness_of(:url).scoped_to(:user_id).case_insensitive }
  end
end
