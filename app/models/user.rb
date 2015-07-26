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
#  is_admin               :boolean          default(FALSE)
#  is_board               :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_and_belongs_to_many :parking_spots

  def self.owners_and_residents
    where('id IN (select user_id from unit_users)')
  end

  def self.orphans
    where('id NOT IN (select user_id from unit_users)')
  end

  def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
       Rails.logger.warn auth.to_json
       user.email = auth.extra.raw_info[:email]
       user.password = Devise.friendly_token[0,20]
       user.name = auth.extra.raw_info[:name]   # assuming the user model has a name
       user.image = auth.extra.raw_info[:picture][:data][:url] # assuming the user model has an image
     end
  end

  protected
    def password_required?
      false
    end
end
