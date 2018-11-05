# == Schema Information
#
# Table name: watchlists
#
#  id                   :bigint(8)        not null, primary key
#  deleted_at           :datetime
#  expires_at           :datetime
#  name                 :string           not null
#  selector             :string           not null
#  url                  :string           not null
#  wait_time_in_minutes :integer          default(60)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :bigint(8)        not null
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
    sequence(:url) { |n| "url_#{n}@example.com" }
    selector { "MyString" }
    wait_time_in_minutes { 120 }
    expires_at { nil }
    association :user, factory: :user
  end
end
