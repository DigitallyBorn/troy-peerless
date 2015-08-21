class EventDecorator < Draper::Decorator
  delegate_all
  include ActionView::Helpers

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def description
    Kramdown::Document.new(object.description).to_html
  end

  def display_date
    distance_of_time_in_words_to_now object.date
  end

  def created_at
    distance_of_time_in_words_to_now object.created_at
  end
end
