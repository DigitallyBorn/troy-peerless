class Admin::UsersController < ApplicationController
  def index
    @presenter = Admin::UserIndexPresenter.new(User.owners_and_residents)
  end

  def show
  end

  def orphans
    @presenter = Admin::UserOrphansPresenter.new(User.orphans)
  end
end
