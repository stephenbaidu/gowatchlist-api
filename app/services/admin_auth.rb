class AdminAuth < ServiceBase
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    valid_email? & valid_password?
  end

  private

  def valid_email?
    admin_email = Rails.application.credentials.admin_email
    SecureCompare.call(@email, admin_email)
  end

  def valid_password?
    admin_password = Rails.application.credentials.admin_password
    SecureCompare.call(@password, admin_password)
  end
end
