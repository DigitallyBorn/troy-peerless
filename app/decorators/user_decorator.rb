class UserDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def created_at
    time_ago_in_words object.created_at
  end

  def lives_in
    "Lives in #{object.unit.number} (on #{object.unit.floor.ordinalize})" if object.unit
  end

  def phone
    number_to_phone object.phone
  end
end
