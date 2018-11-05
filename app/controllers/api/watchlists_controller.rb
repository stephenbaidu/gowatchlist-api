class Api::WatchlistsController < Api::BaseController
  before_action :set_watchlist, only: [:show, :update, :destroy]

  def index
    @watchlists = current_user.watchlists.reorder(id: :desc)
  end

  def show
  end

  def create
    @watchlist = current_user.watchlists.new(watchlist_params)
    @watchlist.save!

    render :show, status: :created
  end

  def update
    @watchlist.update!(watchlist_params)

    render :show, status: :ok
  end

  def destroy
    @watchlist.destroy

    head :no_content
  end

  private

  def set_watchlist
    @watchlist = current_user.watchlists.find(params[:id])
  end

  def watchlist_params
    params.require(:watchlist).permit(:name, :url, :selector, :wait_time_in_minutes, :expires_at)
  end
end
