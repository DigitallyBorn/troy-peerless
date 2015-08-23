class DocumentPolicy < ApplicationPolicy
  def index?
    user.admin? || user.board_member? || user.unit || user.owns.any?
  end

  def show?
    user.admin? || user.board_member? || user.unit || user.owns.any?
  end

  def new?
    user.admin? || user.board_member? || user.unit || user.owns.any?
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
