class Users::VideosController < ApplicationController
  def index
    return all if params[:all] == Settings.conditions.true
  end

  private

  # Need to check super user to do this action.
  # only super user can use this action
  def all
    current_user = User.first # remove this line after login code finish
    videos = VideoProvider.new(current_user).all_users.to_arr_hash
    video_total = videos.count
    page = params[:page]
    videos = Kaminari.paginate_array(videos)
      .page(page).per Settings.videos.per_page
    last_page = (video_total / Settings.videos.per_page).ceil
    responses = {
      videos: videos,
      video_total: video_total,
      current_page: page.to_i,
      last_page: last_page
    }
    render json: responses
  end
end
