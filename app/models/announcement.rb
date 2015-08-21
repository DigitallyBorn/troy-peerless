# == Schema Information
#
# Table name: announcements
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  publish_date :datetime
#  title        :string
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_announcements_on_user_id  (user_id)
#

class Announcement < ActiveRecord::Base
  belongs_to :user

  def self.published
    where("publish_date is not null and publish_date < now()")
      .order(publish_date: :desc)
  end
end
