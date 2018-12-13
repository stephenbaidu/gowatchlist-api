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

class Watchlist < ApplicationRecord
  belongs_to :user
  has_one    :visit_info, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :url, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :selector, presence: true

  scope :ready_for_execution, (lambda do
    where(active: true).where('expires_at IS NULL OR expires_at > ?', Time.now)
  end)

  after_create_commit :create_visit_info
end
