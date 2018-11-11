class AdminAuth < ServiceBase
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    valid_email? & valid_password?
  end

  private

  attr_reader :email, :password

  def valid_email?
    admin_email = Rails.application.credentials.admin_email
    ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(email), ::Digest::SHA256.hexdigest(admin_email)
    )
  end

  def valid_password?
    admin_password = Rails.application.credentials.admin_password
    ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(admin_password)
    )
  end
end
