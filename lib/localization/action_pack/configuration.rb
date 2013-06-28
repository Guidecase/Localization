module ActionPack 
  module Localization
    module Configuration
      extend ActiveSupport::Concern

      module ClassMethods
        def localize_domain(domain, locale)
          naked_domain = domain.gsub('www.','')
          self.localized_domains[naked_domain] = locale
        end
      end      

      included do
        before_filter :set_locale

        cattr_accessor(:localized_domains) { Hash.new }
      end   

      def default_url_options(options={})
        locale_url_options.merge super
      end

      def set_locale
        I18n.locale = user_locale
      end  
   
      protected      

        def user_locale
          params_locale || browser_locale || domain_locale || I18n.locale
        end

        def browser_locale
          get_accept_language_header accept_language
        end      

        def params_locale
          params[:locale]
        end      

        def domain_locale
          self.class.localized_domains[naked_host]
        end       

      private

        def locale_url_options
          { :locale => I18n.locale }
        end

        def accept_language
          request.env['HTTP_ACCEPT_LANGUAGE'] 
        end

        def get_accept_language_header(header)
          header && header.split('-').first.split(',').first
        end

        def naked_host
          request.host.gsub('www.','')      
        end
    end
  end
end