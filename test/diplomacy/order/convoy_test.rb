require 'test_helper'
require 'role/order'

module Diplomacy
  module Order
    class ConvoyTest < Minitest::Test
      include Role::Order

      def setup
        @subject = Convoy.new(
          at: 'FOO',
          from: 'Bar',
          to: 'Baz'
        )
      end

      def test_to_s
        assert_equal 'F FOO C Bar - Baz', @subject.to_s
      end
    end
  end
end
