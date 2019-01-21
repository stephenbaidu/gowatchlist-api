class SelectorFormatter < ServiceBase
  def initialize(selector)
    @selector = selector
  end

  def call
    @selector
      .split('>')
      .map(&:strip)
      .reject { |element| element.include?('#') }
      .map { |element| remove_div_tag(element) }
      .map { |element| extract_css(element) }
      .join(' > ')
  end

  private

  def remove_div_tag(str)
    str[0..3] == 'div.' ? str[3..-1] : str
  end

  def extract_css(str)
    str.include?(':') ? str.split(':').first : str
  end
end
