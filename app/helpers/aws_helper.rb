module AwsHelper
  def presigned_user_image(user_id)
    Aws::S3::PresignedPost.new(get_credentials, 'us-east-1', Rails.application.config.aws_bucket, {
      key: "users/#{user_id}/${filename}",
      key_starts_with: "users/#{user_id}/",
      content_type_starts_with: 'image/',
      content_length_range: 0..5000000,
      acl: 'public-read',
      success_action_redirect: residents_me_aws_callback_url,
      metadata: {
        'original-filename' => '${filename}'
      }
    })
  end

  def presigned_document_upload()
    Aws::S3::PresignedPost.new(get_credentials, 'us-east-1', Rails.application.config.aws_bucket, {
      key: "documents/${filename}",
      key_starts_with: 'documents/',
      allow_any: ['document[category]', 'document[title]'],
      content_length_range: 0..5000000,
      acl: 'private',
      success_action_redirect_starts_with: aws_callback_documents_url,
      metadata: {
        'original-filename' => '${filename}',
        'user' => current_user.name
      }
    })
  end

  def presigned_download_url(key)
    client = Aws::S3::Client.new(
      region: 'us-east-1',
      credentials: get_credentials,
    )
    signer = Aws::S3::Presigner.new client: client
    signer.presigned_url(:get_object, bucket: Rails.application.config.aws_bucket, key: key )
  end

  private

  def get_credentials
    Aws::Credentials.new(
      Rails.application.config.aws_access_key,
      Rails.application.config.aws_access_secret
    )
  end
end
