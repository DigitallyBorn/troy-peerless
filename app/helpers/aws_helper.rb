module AwsHelper
  def presigned_user_image(user_id)
    creds = Aws::Credentials.new(
      Rails.application.config.aws_access_key,
      Rails.application.config.aws_access_secret
    )

    Aws::S3::PresignedPost.new(creds, 'us-east-1', Rails.application.config.aws_bucket, {
      key: "users/#{user_id}/${filename}",
      content_length_range: 0..5000000,
      acl: 'public-read',
      success_action_redirect: residents_me_aws_callback_url,
      metadata: {
        'original-filename' => '${filename}'
      }
    })
  end
end
