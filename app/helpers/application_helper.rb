module ApplicationHelper
  def is_active?(controller_name, page_name)
     params[:controller] == controller_name && params[:action] == page_name
  end
  def get_sexes males, females
    if males != 0 or females != 0
      ('👦'*males)+('👧'*females)
    else
      I18n.t('apartments.nobody_lives_here')
    end
  end
end
