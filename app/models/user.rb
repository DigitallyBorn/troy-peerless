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

##
# The user model
class User < ActiveRecord::Base
  enum role: { normal: 0, admin: 1, board_member: 2 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

  belongs_to :unit
  has_and_belongs_to_many :parking_spots
  has_and_belongs_to_many :owns,
                          join_table: 'users_own_units',
                          class_name: Unit

  after_initialize :set_default_role, if: :new_record?

  validates :name,
            presence: true,
            length: { in: 2..40 }

  validates :email,
            uniqueness: { case_sensitive: false },
            length: { maximum: 254 }

  default_scope lambda {
    order(:name)
  }

  def self.residents
    joins(:unit)
  end

  def self.roommates(user_id, unit_id)
    where(unit_id: unit_id).where.not(id: user_id)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.password = Devise.friendly_token[0, 20]

      user.auth_from_facebook(auth) if auth[:provider] == 'facebook'
      user.auth_from_twitter(auth) if auth[:provider] == 'twitter'
    end
  end

  def self.policy_class
    UserPolicy
  end

  protected

  def password_required?
    false
  end

  def set_default_role
    self.role ||= :normal
  end

  def auth_from_facebook(auth)
    self.email = auth.extra.raw_info[:email]
    self.name = auth.extra.raw_info[:name]
    self.image = auth.extra.raw_info[:picture][:data][:url]
    self.facebook_url = auth.extra.raw_info[:link]
  end

  def self.auth_from_twitter(auth)
    self.email = "#{auth.info.nickname}@twitter-selfs.com"
    self.name = auth.info.name
    self.image = auth.info.image
    self.bio = auth.info.description
    self.twitter_url = auth.info.urls.Twitter
  end
end
