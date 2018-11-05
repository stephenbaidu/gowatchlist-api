class Api::ProfileController < Api::BaseController
  def show
    @user = current_user
  end
end
