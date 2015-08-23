class EventPolicy < ApplicationPolicy
  def index?
    user.admin? || user.board_member? || user.unit || user.owns.any?
  end

  def update?
    user == record.user || user.admin? || user.board_member?
  end

  def destroy?
    user == record.user || user.admin? || user.board_member?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
