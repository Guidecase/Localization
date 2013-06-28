require 'rails/railtie'

module Localization
  class Railtie < Rails::Railtie
    initializer 'localization.load_static_assets' do |app|
      app.middleware.use ::ActionDispatch::Static, "#{Localization.root}/vendor"
    end

    initializer 'localization.view_helpers' do
      ActionView::Base.send :include, ActionView::Helpers::Localization::LocaleUrlHelper
    end

    initializer 'localization.append_app_i18n_path' do |app|
      app.config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    end    
  end
end