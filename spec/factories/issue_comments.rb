# == Schema Information
#
# Table name: issue_comments
#
#  id         :integer          not null, primary key
#  issue_id   :integer          not null
#  user_id    :integer          not null
#  body       :text             not null
#  is_deleted :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_issue_comments_on_issue_id  (issue_id)
#  index_issue_comments_on_user_id   (user_id)
#

FactoryGirl.define do
  factory :issue_comment do
    issue nil
user nil
body "MyText"
  end

end
