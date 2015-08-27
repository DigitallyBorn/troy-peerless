class IssueDecorator < Draper::Decorator
  delegate_all

  def created_at
    h.time_ago_in_words object.created_at
  end

  def updated_at
    h.time_ago_in_words object.updated_at
  end

  def estimated_completion_text
    return '' if object.closed?
    return "" unless object.estimated_completion

    distance_in_words = h.time_ago_in_words object.estimated_completion

    if object.estimated_completion < DateTime.now
      "Should have been completed #{distance_in_words} ago"
    else
      "Should be completed in #{distance_in_words}"
    end
  end

  def status_color
    return 'success' if object.closed?
    return 'danger' if object.estimated_completion && object.estimated_completion < DateTime.now
    'default'
  end
end
