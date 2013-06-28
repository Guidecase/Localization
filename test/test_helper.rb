require 'ansi/code'
require 'turn'
require 'minitest/autorun'
require 'minitest/mock'
require 'ostruct'

module MiniTest
  class Unit
    class TestCase
      def refute_predicate
        # MONKEYPATCH: Rails 4 test/unit does not include this method which is aliased by minitest and then 
        # raises an exception. Opening the class to add this mock method fixes the issue.
      end        
    end
  end
end

require 'action_view/test_case'

require_relative '../lib/localization'