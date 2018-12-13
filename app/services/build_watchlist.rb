class BuildWatchlist < ServiceBase
  class InvalidUrlError < StandardError; end
  class ItemNotFoundError < StandardError; end

  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    raise InvalidUrlError unless site_url =~ URI::regexp
    raise ItemNotFoundError unless css_selector.present?

    @user.watchlists.new(watchlist_params)
  end

  private

  def site_url
    @params[:url]
  end

  def item_url
    @params[:item_url]
  end

  def css_selector
    @css_selector ||= CssSelectorFromUrls.call(site_url, item_url)
  end

  def watchlist_params
    {
      name: @params[:name],
      url: site_url,
      selector: SelectorFormatter.call(css_selector)
    }
  end
end
