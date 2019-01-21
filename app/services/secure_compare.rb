class SecureCompare < ServiceBase
  def initialize(first, second)
    @first = first
    @second = second
  end

  def call
    ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(@first), ::Digest::SHA256.hexdigest(@second)
    )
  end
end
