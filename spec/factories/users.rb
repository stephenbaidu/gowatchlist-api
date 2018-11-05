# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  deleted_at      :datetime
#  email           :string
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE WHERE (deleted_at IS NULL)
#

FactoryBot.define do
  factory :user do
    name { "MyString" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password_digest { "MyString" }
  end
end
