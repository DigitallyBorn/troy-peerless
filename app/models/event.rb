# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  date        :date
#  title       :string
#  description :text
#  location    :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

##
# The event model
class Event < ActiveRecord::Base
  validates :title, presence: true
  validates :date, presence: true
  validates :user_id, presence: true

  belongs_to :user

  def self.upcoming
    where('date > now()')
  end
end
