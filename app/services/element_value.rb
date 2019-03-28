class ElementValue < ServiceBase
  def initialize(element)
    @element = element
  end

  def call
    @element.attr('href') || @element.content
  end
end
