class HomeController < ApplicationController
  before_action :authenticate_user!
  decorates_assigned :users

  def index
    @announcements = AnnouncementPolicy::Scope.new(current_user, Announcement).resolve.decorate
  end

  def board
    @users = User.board
  end

end
