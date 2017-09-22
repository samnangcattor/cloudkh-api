class DrivesController < ApplicationController
  CREDENTIALS_PATH = File.join Settings.drives.credentials.path,
    Settings.drives.credentials.format, Settings.drives.yamls.full
  SCOPE = %w(https://www.googleapis.com/auth/plus.me
    https://www.googleapis.com/auth/userinfo.profile
    https://www.googleapis.com/auth/userinfo.email
    https://www.googleapis.com/auth/drive
    https://www.googleapis.com/auth/calendar
    https://mail.google.com/
    openid email profile)

  def index
    service = Google::Apis::CalendarV3::CalendarService.new.tap do |client|
      client.request_options.timeout_sec = Settings.timeout
      client.request_options.open_timeout_sec = Settings.timeout
      client.request_options.retries = Settings.retries
    end
    service.client_options.application_name = Settings.drives.application_name
    service.authorization = authorize
  end

  def update
    client_id = Google::Auth::ClientId.from_file Settings.drives.client_secret_paths.full
    token_store = Google::Auth::Stores::FileTokenStore.new file: CREDENTIALS_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = Settings.drives.user_id
    code = params[:code]
    authorizer.get_and_store_credentials_from_code code: code,
      user_id: user_id, base_url: Settings.drives.oob_uri
    redirect_to drives_path
  end

  private
  def authorize
    FileUtils.mkdir_p File.dirname(CREDENTIALS_PATH)

    client_id = Google::Auth::ClientId.from_file Settings.drives.client_secret_paths.full
    token_store = Google::Auth::Stores::FileTokenStore.new file: CREDENTIALS_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = Settings.drives.user_id
    credentials = authorizer.get_credentials user_id
    if credentials.nil?
      url = authorizer.get_authorization_url base_url: Settings.drives.oob_uri
      redirect_to url
    end
    credentials
  end
end
