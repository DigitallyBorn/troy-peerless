class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @announcements = Announcement.published.decorate
  end
end
