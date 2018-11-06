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
  pending "add some examples to (or delete) #{__FILE__}"
end
