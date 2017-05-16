class VideoProvider
  def initialize user
    @videos = user.videos
  end

  def all_users
    @videos = Video.eager_load(:user)
    self
  end

  def to_arr_hash
    @videos.reduce([]) do |result, video|
      result << {
        id: video.id,
        title: video.title,
        owner: {
          id: video.user.id,
          name: video.user.name
        },
        status: video.status,
        mime_type: video.mime_type,
        google_file: video.google_file,
        created_at: video.created_at
      }
    end
  end

  def count_by_status
    {
      total: @videos.count,
      done: @videos.done.count,
      progress: @videos.progress.count,
      ban: @videos.ban.count
    }
  end
end
