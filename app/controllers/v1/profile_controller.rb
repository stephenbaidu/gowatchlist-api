class V1::ProfileController < V1::BaseController
  def show
    @user = current_user
  end
end
