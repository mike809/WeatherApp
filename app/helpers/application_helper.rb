module ApplicationHelper
  def alert_class_for(flash_type)
    {
      notice: "alert-success",
      error: "alert-danger"
    }[flash_type.to_sym] || "alert-#{flash_type.to_s}"
  end
end
