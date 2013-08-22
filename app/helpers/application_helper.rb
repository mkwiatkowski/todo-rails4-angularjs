module ApplicationHelper
  def active_if_current(path)
    'active' if current_page?(path)
  end
end
