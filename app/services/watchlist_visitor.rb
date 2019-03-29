class WatchlistVisitor < ServiceBase
  def initialize(watchlist)
    @watchlist = watchlist
    @visit_info = watchlist.visit_info
  end

  def call
    return unless @visit_info
    return unless content

    UpdateVisit.call(@visit_info, content)

    if @visit_info.new_content?
      WatchlistMailer.alert(@watchlist).deliver_later
    end
  end

  private

  def content
    @content ||= fetcher.call
  end

  def fetcher
    @fetcher ||= ContentFetcher.new(@watchlist.url, css_selector)
  end

  def css_selector
    SelectorFormatter.call(@watchlist.selector)
  end
end
