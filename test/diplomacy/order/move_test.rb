require 'test_helper'
require 'role/order'

module Diplomacy
  module Order
    class MoveTest < Minitest::Test
      include Role::Order

      def setup
        @subject = Move.new(unit: :foo, from: 'Bar', to: 'Baz')
      end
    end
  end
end
