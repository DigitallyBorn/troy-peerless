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
#
# Indexes
#
#  index_issues_on_unit_id  (unit_id)
#  index_issues_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Issue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
