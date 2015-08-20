Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.config.facebook_appid, Rails.application.config.facebook_secret,
           :scope => 'email,public_profile',
           :info_fields => 'email,name,picture.width(256),gender,link',
           :secure_image_url => true

  provider :twitter,
            Rails.application.config.twitter_consumer_key,
            Rails.application.config.twitter_consumer_secret,
            {
              image_size: 'bigger',
              secure_image_url: true
            }
end
