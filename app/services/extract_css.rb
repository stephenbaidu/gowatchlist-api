class ExtractCss < ServiceBase
  def initialize(selector)
    @selector = selector
  end

  def call
    @selector.include?(':') ? @selector.split(':').first : @selector
  end
end
