class Admin::UserOrphansPresenter
  attr_reader :users

  def initialize(users)
    @users = users
    Rails.logger.info users.count
  end
end
