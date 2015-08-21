class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @announcements = AnnouncementPolicy::Scope.new(current_user, Announcement).resolve.decorate
  end
end
