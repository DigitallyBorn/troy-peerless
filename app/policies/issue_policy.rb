class IssuePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if @user.admin?

      sql = <<-EOL
      scope = #{Issue.scopes[:for_building]}
      OR
      user_id = #{@user.id}
      EOL

      sql += " OR scope = #{Issue.scopes[:for_board]}" if @user.board_member?
      puts sql
      scope.where(sql)
    end
  end

  def permitted_attributes
    if user.owner_of?(record)
      [ :title, :description, :unit_id, :status ]
    elsif user.admin? || user.board_member?
      [ :status, :estimated_completion ]
    end
  end

  def add_comment?
    record.user == user ||
    user.admin? ||
    user.board_member? ||
    record.unit.owners.include?(user) ||
    record.unit.users.include?(user)
  end

  def close?
    record.user == user ||
    user.admin? ||
    user.board_member? ||
    record.unit.owners.include?(user) ||
    record.unit.users.include?(user)
  end
end
