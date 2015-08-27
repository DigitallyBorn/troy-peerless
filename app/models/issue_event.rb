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

class IssueEvent < ActiveRecord::Base
  belongs_to :issue, counter_cache: :event_count, touch: true
  belongs_to :user

  enum event_type: { closed: 0, reopened: 1, set_completion_date: 2 }

  validates :issue, :user, :event_type, presence: true
end
