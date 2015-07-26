class UserPolicy < ApplicationPolicy
  attr_reader :user, :resource

  def new (user, resource)
    @user = user
    @resource = resource
  end

  def update?
    @user.is_admin || @user.is_board || @user.id == @resource.id
  end
end
