##
# Provides baseline security policy for the application
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.admin? || @user.board_member? || @user.owns.any? || @user.unit
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    @user.admin? || @user.board_member?
  end

  def new?
    create?
  end

  def update?
    @user.admin? || @user.board_member?
  end

  def edit?
    update?
  end

  def destroy?
    @user.admin? || @user.board_member?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  ##
  # Provides a baseline security-aware scope
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
