class V1::WatchlistsController < V1::BaseController
  before_action :set_watchlist, only: [:show, :update, :destroy, :activate, :deactivate]

  def index
    @watchlists = current_user.watchlists.reorder(id: :desc)
  end

  def show
  end

  def create
    @watchlist = BuildWatchlist.call(current_user, create_watchlist_params)
    @watchlist.save!

    render :show, status: :created
  rescue BuildWatchlist::InvalidUrlError
    render json: { errors: { base: ['Url is not valid'] } }, status: :unprocessable_entity
  rescue BuildWatchlist::ItemNotFoundError
    render json: { errors: { base: ['Item was not found on the page'] } }, status: :unprocessable_entity
  end

  def update
    @watchlist.update!(update_watchlist_params)

    render :show, status: :ok
  end

  def destroy
    @watchlist.destroy

    head :no_content
  end

  def activate
    @watchlist.update(active: true)

    head :ok
  end

  def deactivate
    @watchlist.update(active: false)

    head :ok
  end

  private

  def set_watchlist
    @watchlist = current_user.watchlists.find(params[:id])
  end

  def create_watchlist_params
    params.require(:watchlist).permit(:name, :url, :item_url)
  end

  def update_watchlist_params
    params.require(:watchlist).permit(:name)
  end
end
