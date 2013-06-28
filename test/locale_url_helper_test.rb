require_relative 'test_helper'

class LocaleUrlHelperTest < MiniTest::Unit::TestCase
  include ActionView::Helpers::Localization::LocaleUrlHelper

  def test_localized_path
    request.expect :path, '/path/to/page'
    assert_equal '/en/path/to/page', localized_path('en')
  end

  def test_link_locale_to_new_action_with_post_request
    request.expect :post?, true
    params[:action] = 'index'
    assert_equal false, link_locale_to_new_action?

    request.expect :post?, true
    params[:action] = 'create'
    assert_equal true, link_locale_to_new_action?
  end

  def test_link_locale_to_new_action_without_post_request
    request.expect :post?, false
    params[:action] = 'create'
    assert_equal false, link_locale_to_new_action?
  end  

  def test_relocalized_path
    current_language = 'en'
    new_language = 'nl'
    request.expect :path, "/#{current_language}/path/to/page"
    request.expect :post?, false
    params[:locale] = current_language

    assert_equal "/#{new_language}/path/to/page", relocalized_path(new_language)
  end

  def test_relocalized_path_with_create
    current_language = 'en'
    new_language = 'nl'
    request.expect :path, "/#{current_language}/path/to/page"
    request.expect :post?, true
    params[:action] = 'create'
    params[:locale] = current_language

    assert_equal "/#{new_language}/path/to/page/new", relocalized_path(new_language)
  end

  def test_locale_path_with_language_param
    current_language = 'en'
    new_language = 'nl'
    params[:locale] = current_language
    request.expect :post?, false
    request.expect :path, "/#{current_language}/path"

    assert_equal "/#{new_language}/path", locale_path(new_language)
  end

  def test_locale_path_without_language_param
    current_language = 'en'
    new_language = 'nl'
    request.expect :post?, false
    request.expect :path, "/path"

    assert_equal "/#{new_language}/path", locale_path(new_language)    
  end

  def test_link_to_locale
    request.expect :post?, false
    request.expect :path, "/path"
    body = 'testing'
    language = 'en'
    output = link_to_locale language, body, :class => 'test'

    assert_equal "<a class=\"test\" href=\"/#{language}/path\">#{body}</a>", output
  end

  private

    def request
      @mock_request ||= MiniTest::Mock.new
    end

    def params
      @params ||= {}
    end

    def link_to(body, url, opts={})
      "<a class=\"#{opts[:class]}\" href=\"#{url}\">#{body}</a>"
    end
end