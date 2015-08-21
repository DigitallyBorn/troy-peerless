class AnnouncementPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize (user, model)
    @user = user
    @model = model
  end

  def index?
    user.admin? || user.board_member? || user.unit || user.owns.any?
  end

  def show?
    user.admin? || user.board_member? || user.unit || user.owns.any?
  end

  def new?
    user.admin? || user.board_member?
  end

  def destroy?
    user.admin? || user.board_member?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
