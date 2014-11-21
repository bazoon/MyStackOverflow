if Rails.env.development? || Rails.env.test?
  I18n.exception_handler = lambda do |exception, locale, key, options|
    if exception.is_a?(I18n::MissingTranslation) && key.to_s != 'i18n.plural.rule'
      raise "missing translation: #{key}"
    else
      
    end

  end
end