module ApplicationHelper
  FLASH_KEYS = {
    success: 'success',
    alert: 'warning',
    warning: 'warning',
    error: 'danger'
  }

  def flash_css_name(key)
    Rails.logger.debug "Flash message #{key}"
    FLASH_KEYS[key] || 'info'
  end
end
