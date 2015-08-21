class AnnouncementDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def body
    Kramdown::Document.new(object.body).to_html
  end

  def publish_date
    "#{helpers.time_ago_in_words object.publish_date} ago"
  end

end
