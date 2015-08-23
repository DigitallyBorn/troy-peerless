##
# Handles security policy for the announcement model
class AnnouncementPolicy < ApplicationPolicy
  def index?
    user.admin? || user.board_member? || user.unit || user.owns.any?
  end

  def update?
    user.admin? || user.board_member?
  end

  def new?
    user.admin? || user.board_member?
  end

  def destroy?
    user.admin? || user.board_member?
  end

  ##
  # Provides an activerecord scope that is security aware
  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin? || user.board_member?
        scope.all
      else
        scope.where('publish_date is not null and publish_date < now()')
      end
    end
  end
end
