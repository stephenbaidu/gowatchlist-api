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

class VisitInfo < ApplicationRecord
  belongs_to :watchlist

  def update_visit(new_content)
    with_lock do
      self.visits = visits + 1
      self.previous_content = previous_content | current_content
      self.current_content = new_content

      if (current_content - previous_content).present?
        self.alerts = alerts + 1
      end

      save
    end
  end

  def new_content?
    (current_content - previous_content).present?
  end
end
