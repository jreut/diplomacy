$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'diplomacy'

require 'minitest/autorun'

module Minitest
  class Test
    parallelize_me!

    def assert_failure_message(matcher, result)
      result
        .fmap { |value| flunk "got #{value} instead of failure" }
        .or { |failure| assert_match matcher, failure }
    end
  end
end
