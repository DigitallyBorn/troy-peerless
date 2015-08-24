##
# Handles security policy for the user model
class UserPolicy < ApplicationPolicy
  def default?
    @user.admin? || @user.board_member? || @user.unit || @user.owns.any?
  end

  def update?
    @user.admin? || @user.board_member? || @user == @record
  end

  def change_role?
    (@user.admin? || @user.board_member?) && @user.id != @record.id
  end

  alias_method :index?, :default?
  alias_method :show?, :default?

  def permitted_attributes
    fields = [:name, :email, :shared_email, :phone, :occupation, :bio, :phone,
              :can_sms] if user.id == model.id && user.admin?
    fields += [:own_ids, :unit_id] if user.admin?
    fields
  end
end
