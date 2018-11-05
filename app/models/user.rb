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

class User < ApplicationRecord
  has_secure_password

  has_many :watchlists

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
end
