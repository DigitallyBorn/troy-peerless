class UnitPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if @user.admin? || @user.board_member?

      scope.where("id in (select unit_id from users_own_units where user_id = #{@user.id})
      OR id = (select unit_id from users where users.id = #{@user.id})")
    end
  end
end
