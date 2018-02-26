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
    end
  end
end
