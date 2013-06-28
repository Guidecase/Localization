module ActionView
  module Helpers
    module Localization
      module LocaleUrlHelper
        def link_to_locale(locale, body, opts = {})
          link_to body, locale_path(locale), opts
        end        

        private

          def locale_path(locale)
            params[:locale] ? relocalized_path(locale) : localized_path(locale)
          end

          def relocalized_path(locale)
            path = request.path.gsub /\/#{params[:locale].to_s}/, "/#{locale.to_s}"
            link_locale_to_new_action? ? "#{path}/new" : path
          end

          def link_locale_to_new_action?
            request.post? && params[:action] == 'create'
          end

          def localized_path(locale)
            "/#{locale}#{request.path}"
          end
      end
    end
  end
end