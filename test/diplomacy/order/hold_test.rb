require 'test_helper'
require 'role/order'

module Diplomacy
  module Order
    class HoldTest < Minitest::Test
      include Role::Order

      def setup
        @subject = Hold.new(unit: :bongo, at: 'XYZ')
      end
    end
  end
end
