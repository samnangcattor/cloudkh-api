class GoogleDrive
  class << self
    def get_service_full
      service = Google::Apis::DriveV3::DriveService.new.tap do |client|
        client.request_options.timeout_sec = Settings.timeout
        client.request_options.open_timeout_sec = Settings.timeout
        client.request_options.retries = Settings.retries
      end
      client_secret_path = Settings.drives.client_secret_paths.full
      credentials_path = File.join Settings.drives.credentials.path,
        Settings.drives.credentials.format, Settings.drives.yamls.full
      scope = Settings.drives.scopes.full
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
      client_secret_path = Settings.drives.client_secret_paths.read_only
      credentials_path = File.join Settings.drives.credentials.path,
        Settings.drives.credentials.format, Settings.drives.yamls.read_only
      scope = Settings.drives.scopes.read_only
      authorization = authorize client_secret_path, credentials_path, scope
      service.authorization = authorization
      service
    end

    def get_access_token service
      redis = Redis.new
      redis_key = Settings.drives.access_token + service.authorization.scope[0]
      access_token = redis.get redis_key
      unless access_token.present?
        service.get_file Settings.drives.file
        access_token = service.authorization.access_token
        redis.set redis_key, access_token
        redis.expire redis_key, Settings.drives.timeout
      end
      access_token
    end

    private
    def authorize client_secret_path, credentials_path, scope
      FileUtils.mkdir_p File.dirname(credentials_path)

      client_id = Google::Auth::ClientId.from_file client_secret_path
      token_store = Google::Auth::
        Stores::FileTokenStore.new file: credentials_path
      authorizer = Google::Auth::UserAuthorizer.new client_id,
        scope, token_store
      user_id = Settings.drives.user_id
      credentials = authorizer.get_credentials user_id
      credentials
    end
  end
end
