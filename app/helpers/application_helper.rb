module ApplicationHelper
  def is_active?(controller_name, page_name)
     params[:controller] == controller_name && params[:action] == page_name
  end
end
