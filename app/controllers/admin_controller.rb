class AdminController < ApplicationController
  before_action :check_log
  def home
  end

  def check_log
    binding.pry
    return if admin_signed_in?

    cookies[:return_to] = request.url
    redirect_to new_admin_session_path, gflash: { notice: "You must be logged in to do that" }
  end
end
