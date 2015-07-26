class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

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
