Aws.config.update({
  region: 'us-east-1',
  credentials: Aws::Credentials.new(
    Rails.application.config.aws_access_key,
    Rails.application.config.aws_access_secret),
})
