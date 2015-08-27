# == Schema Information
#
# Table name: issue_events
#
#  id         :integer          not null, primary key
#  issue_id   :integer          not null
#  user_id    :integer          not null
#  event_type :integer          not null
#  message    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_issue_events_on_issue_id  (issue_id)
#  index_issue_events_on_user_id   (user_id)
#

FactoryGirl.define do
  factory :issue_event do
    issue nil
user nil
type 1
  end

end
