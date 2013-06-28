require 'rails/engine'
require 'action_view'

module Localization
  LOCALES = %w{en nl}
  
  def self.root
    File.dirname(__FILE__)
  end
end

require_relative "localization/action_view/locale_url_helper"
require_relative "localization/action_pack/configuration"

require_relative "localization/rails/railtie" if defined?(Rails)