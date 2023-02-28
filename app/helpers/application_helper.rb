module ApplicationHelper
  include Pagy::Frontend

  ALERTS = {
    notice: 'info',
    error: 'danger',
    success: 'success',
    alert: 'warning'
  }.freeze

  def flash_to_alert(flash)
    ALERTS[flash.to_sym]
  end

  def representable_any(files)
    selected_files = files&.select(&:representable?)
    selected_files.any? ? selected_files.first : false
  end
end
