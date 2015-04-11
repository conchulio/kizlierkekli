module ApartmentsHelper
  def get_names_from_number num
    I18n.t('apartments.male_or_female')[num]
  end

  def currencies
    curs = ['€', '$', '£', 'TRY']
    case I18n.locale
    when :tr
      curs.delete('TRY')
      curs.unshift('TRY')
    end
    curs
  end
end
