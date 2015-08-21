class UserPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize (user, model)
    @user = user
    @model = model
  end

  def default?
    @user.admin? || @user.board_member? || @user == @model
  end

  def change_role?
    @user.admin? && @user.id != @model.id
  end

  alias_method :index?, :default?
  alias_method :show?, :default?
  alias_method :update?, :default?

  def permitted_attributes
    [:name, :email, :shared_email, :phone, :occupation, :bio, :phone, :can_sms] if user.id == model.id
    [:name, :email, :shared_email, :phone, :occupation, :bio, :phone, :can_sms, :own_ids, :unit_id] if user.admin?
  end
end
