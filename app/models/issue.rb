# == Schema Information
#
# Table name: issues
#
#  id                   :integer          not null, primary key
#  user_id              :integer          not null
#  unit_id              :integer
#  title                :string           not null
#  description          :text             not null
#  status               :integer          default(0), not null
#  scope                :integer          default(0), not null
#  estimated_completion :date
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  comment_count        :integer          default(0)
#  event_count          :integer          default(0)
#
# Indexes
#
#  index_issues_on_unit_id  (unit_id)
#  index_issues_on_user_id  (user_id)
#

class Issue < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit

  has_many :events, class_name: 'IssueEvent'
  has_many :comments, class_name: 'IssueComment'

  enum status: { open: 0, closed: 1 }
  enum scope: { for_owner: 0, for_board: 1, for_building: 2 }

  validates :user, :unit, :status, presence: true
  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10 }

  def close!(user)
    self.closed!

    IssueEvent.create issue: self,
                      user: user,
                      event_type: IssueEvent.event_types[:closed],
                      message: "#{user.name} closed the issue."
  end
end
