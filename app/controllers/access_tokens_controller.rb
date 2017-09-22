class AccessTokensController < ApplicationController
  def index
    service = GoogleDrive.get_service_full
    access_token = GoogleDrive.get_access_token service
    render json: {access_token: access_token}
  end
end
