class UsersController < ApplicationController
  def index
    users = User.all
    user_total = users.count
    page = params[:page]
    users = users.page(page).per Settings.users.per_page
    last_page = user_total / Settings.users.per_page
    response = {
      users: users,
      user_total: user_total,
      current_page: page.to_i,
      last_page: last_page
    }
    render json: response
  end
end
