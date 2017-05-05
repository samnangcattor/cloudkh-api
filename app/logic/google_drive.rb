class GoogleDrive
  class << self
    def get_service_full
      service = Google::Apis::DriveV3::DriveService.new.tap do |client|
        client.request_options.timeout_sec = Settings.timeout
        client.request_options.open_timeout_sec = Settings.timeout
        client.request_options.retries = Settings.retries
      end
      client_secret_path = "lib/google_drive/client_secret.json"
      credentials_path = File.join "lib/google_drive/",
        ".credentials", "cloudkh_full.yaml"
      scope = "https://www.googleapis.com/auth/drive"
      authorization = authorize client_secret_path, credentials_path, scope
      service.authorization = authorization
      service
    end

    def get_service_read
      service = Google::Apis::DriveV3::DriveService.new.tap do |client|
        client.request_options.timeout_sec = Settings.timeout
        client.request_options.open_timeout_sec = Settings.timeout
        client.request_options.retries = Settings.retries
      end
      client_secret_path = "lib/google_drive/client_secret_read.json"
      credentials_path = File.join "lib/google_drive/",
        ".credentials", "cloudkh_read.yaml"
      scope = "https://www.googleapis.com/auth/drive.readonly"
      authorization = authorize client_secret_path, credentials_path, scope
      service.authorization = authorization
      service
    end

    private
    def authorize client_secret_path, credentials_path, scope
      FileUtils.mkdir_p File.dirname(credentials_path)

      client_id = Google::Auth::ClientId.from_file client_secret_path
      token_store = Google::Auth::
        Stores::FileTokenStore.new file: credentials_path
      authorizer = Google::Auth::UserAuthorizer.new client_id,
        scope, token_store
      user_id = "default"
      credentials = authorizer.get_credentials user_id
      credentials
    end
  end
end
