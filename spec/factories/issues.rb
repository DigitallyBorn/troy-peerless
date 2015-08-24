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

FactoryGirl.define do
  factory :issue do
    submitter nil
title "MyString"
description "MyText"
status 1
  end

end
