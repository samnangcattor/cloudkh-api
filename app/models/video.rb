class Video < ApplicationRecord
  belongs_to :user

  enum status: Settings.videos.status.map(&:first)
  enum mime_type: Settings.videos.mime_types(&:first)
end
