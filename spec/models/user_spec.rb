require 'rails_helper'

RSpec.describe User, type: :model do
  it "should require a name" do
    expect(FactoryGirl.build(:user, :name => "")).not_to be_valid

  end

  it "should require an email" do
    expect(FactoryGirl.build(:user, :email => "")).not_to be_valid
  end

  it "should default to a normal role" do
    expect(FactoryGirl.build(:user).normal?).to be true
  end
end
