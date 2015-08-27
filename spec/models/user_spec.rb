# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  name                   :string
#  image                  :string
#  role                   :integer
#  shared_email           :string
#  phone                  :string
#  can_sms                :boolean
#  occupation             :string
#  bio                    :text
#  gender                 :string
#  facebook_url           :string
#  unit_id                :integer
#  twitter_url            :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_provider              (provider)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid                   (uid)
#  index_users_on_unit_id               (unit_id)
#

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
