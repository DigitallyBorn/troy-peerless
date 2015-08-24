require 'spec_helper'

describe UserPolicy do
  let(:user) { FactoryGirl.create :user }
  let(:resident) { build_stubbed(:user, unit_id: 1) }
  let(:admin) { FactoryGirl.create :admin }
  let(:board_member) { FactoryGirl.create :board_member }

  subject { described_class }

  permissions :show? do
    it "denies non-residents access to residents" do
      expect(subject).not_to permit(user, resident)
    end

    it "allows admins to see all other users" do
      expect(subject).to permit(admin, user)
      expect(subject).to permit(admin, resident)
      expect(subject).to permit(admin, board_member)
      expect(subject).to permit(admin, admin)
    end

    it "allows board members to see all other users" do
      expect(subject).to permit(board_member, user)
      expect(subject).to permit(board_member, resident)
      expect(subject).to permit(board_member, board_member)
      expect(subject).to permit(board_member, admin)
    end

    it "allows residents to see all other users" do
      expect(subject).to permit(resident, user)
      expect(subject).to permit(resident, resident)
      expect(subject).to permit(resident, board_member)
      expect(subject).to permit(resident, admin)
    end

  end
end
