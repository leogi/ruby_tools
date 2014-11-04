module ApplicationHelper
  def available_locales
    Settings.available_locales.map do |l|
      [I18n.t('language', locale: l.to_sym), l]
    end
  end

  def is_admin?
    controller.is_a? Admin::BaseController
  end
end
