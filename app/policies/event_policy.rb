class EventPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize (user, model)
    @user = user
    @model = model
  end

  def update?
    user == model.user || user.admin? || user.board_member?
  end

  def destroy?
    user == model.user || user.admin? || user.board_member?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
