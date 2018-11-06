class WatchlistHandler < ServiceBase
  def initialize(watchlist)
    @watchlist = watchlist
    @visit_info = watchlist.visit_info
  end

  def call
    return unless visit_info
    return unless content

    visit_info.update_content(content)

    if visit_info.new_content?
      # Send email
    end
  end

  private

  attr_reader :watchlist, :visit_info

  def content
    @content ||= fetcher.call
  end

  def fetcher
    @fetcher ||= ContentFetcher.new(watchlist.url, css_selector)
  end

  def css_selector
    SelectorFormatter.call(watchlist.selector)
  end
end
