require_relative 'test_helper'

class ConfigurationTest < MiniTest::Unit::TestCase
  class << self
    def before_filter(method); end
  end

  include ActionPack::Localization::Configuration

  def teardown
    ConfigurationTest.localized_domains = {}
  end

  def request
    @request ||= OpenStruct.new(:path => 'test/path', :host => 'www.example.com', :env => {})
  end  

  def params; @params ||= {}; end

  def test_localize_domain
    language = 'nl'
    domain = 'example.com'
    ConfigurationTest.localize_domain domain, language
    
    assert_equal language, ConfigurationTest.localized_domains[domain]
  end

  def test_that_naked_host_strips_www
    assert_equal 'example.com', naked_host
  end

  def test_that_locale_url_options_has_default_locale
    assert_equal I18n.locale, locale_url_options[:locale]
  end

  def test_accept_language_from_env
    request.env['HTTP_ACCEPT_LANGUAGE'] = 'test'
    assert_equal 'test', accept_language
  end

  def test_get_accept_language_header_from_language_and_location_string
    assert_equal 'en', get_accept_language_header('en-US')
  end

  def test_get_accept_language_header_from_language_string
    assert_equal 'en', get_accept_language_header('en')
  end  

  def test_domain_locale
    ConfigurationTest.localized_domains['example.com'] = 'fr'
    assert_equal 'fr', domain_locale
  end

  def test_params_locale
    assert_nil params_locale
    params[:locale] = 'fr'
    assert_equal 'fr', params_locale
  end

  def test_browser_locale
    request.env['HTTP_ACCEPT_LANGUAGE'] = 'fr'
    assert_equal 'fr', browser_locale
  end

  def test_user_locale
    ConfigurationTest.instance_variable_set('@localized_domains', {})

    I18n.locale = 'pt'
    assert_equal 'pt', user_locale.to_s

    ConfigurationTest.localized_domains['example.com'] = 'fi'
    assert_equal 'fi', user_locale

    request.env['HTTP_ACCEPT_LANGUAGE'] = 'es'
    assert_equal 'es', user_locale

    params[:locale] = 'it'
    assert_equal 'it', user_locale
  end
end