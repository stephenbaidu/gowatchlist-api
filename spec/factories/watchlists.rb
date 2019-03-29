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

FactoryBot.define do
  factory :watchlist do
    sequence(:name) { |n| "Watchlist #{n}" }
    sequence(:url) { |n| "https://url_#{n}@example.com" }
    selector { 'MyString' }
    expires_at { nil }
    active { true }
    association :user, factory: :user
  end
end
