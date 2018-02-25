require 'test_helper'
require 'role/order'

module Diplomacy
  module Order
    class SupportTest < Minitest::Test
      include Role::Order

      def setup
        @subject = Support.new(
          unit: :bango,
          at: 'GNV',
          order: Hold.new(
            unit: nil,
            at: 'ATL'
          )
        )
      end
    end
  end
end
