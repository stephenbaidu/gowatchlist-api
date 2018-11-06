class SelectorFormatter < ServiceBase
  attr_reader :selector, :value

  def initialize(selector)
    @selector = selector
  end

  def call
    arr = selector.split('>')
    @value =
      arr.map(&:strip)
      .map { |e| e[0..3] == 'div.' ? e[3..-1] : e }
      .map { |e| e.include?(':nth-child') ? e.split(':nth-child').first : e }
      .join(' ')

    value
  end
end
