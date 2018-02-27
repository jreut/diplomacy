# frozen_string_literal: true

require 'test_helper'
require 'role/order'

module Diplomacy
  module Order
    class SupportTest < Minitest::Test
      include Role::Order

      def setup
        @subject = Support.new(
          unit: :army,
          at: 'GNV',
          target: Supported::Hold.new(at: 'ATL')
        )
      end

      def test_to_s
        assert_equal 'A GNV S ATL H', @subject.to_s
      end
    end
  end
end
