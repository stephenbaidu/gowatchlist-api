# == Schema Information
#
# Table name: visit_infos
#
#  id               :bigint(8)        not null, primary key
#  alerts           :integer          default(0)
#  current_content  :text             default([]), is an Array
#  previous_content :text             default([]), is an Array
#  visits           :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  watchlist_id     :bigint(8)        not null
#
# Indexes
#
#  index_visit_infos_on_watchlist_id  (watchlist_id)
#

require 'rails_helper'

RSpec.describe VisitInfo, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:watchlist) }
  end

  describe '#new_content?' do
    let(:visit_info) { build :visit_info, previous_content: previous_content, current_content: current_content }
    subject { visit_info.new_content? }

    context 'when current_content has a new element' do
      let(:previous_content) { ['a', 'b', 'c'] }
      let(:current_content) { ['a', 'd'] }

      it 'returns true' do
        expect(subject).to eq(true)
      end
    end

    context 'when current_content does not have a new element' do
      let(:previous_content) { ['a', 'b', 'c'] }
      let(:current_content) { ['c', 'a'] }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end
  end
end
