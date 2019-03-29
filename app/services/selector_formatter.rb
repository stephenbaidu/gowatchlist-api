class SelectorFormatter < ServiceBase
  def initialize(selector)
    @selector = selector
  end

  def call
    @selector
      .split('>')
      .map(&:strip)
      .reject { |selector| selector.include?('#') }
      .map { |selector| RemoveDivTag.call(selector) }
      .map { |selector| ExtractCss.call(selector) }
      .join(' > ')
  end
end
