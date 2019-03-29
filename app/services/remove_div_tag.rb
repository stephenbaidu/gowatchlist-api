class RemoveDivTag < ServiceBase
  def initialize(selector)
    @selector = selector
  end

  def call
    @selector[0..3] == 'div.' ? @selector[3..-1] : @selector
  end
end
