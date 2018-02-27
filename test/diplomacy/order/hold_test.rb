# frozen_string_literal: true

require 'test_helper'
require 'role/order'
require 'role/supportable'

module Diplomacy
  module Order
    class HoldTest < Minitest::Test
      include Role::Order
      include Role::Supportable

      def setup
        @subject = Hold.new(unit: :army, at: 'XYZ')
      end

      def test_destination_is_at
        assert_equal 'XYZ', @subject.destination
      end

      def test_to_s
        assert_equal 'A XYZ H', @subject.to_s
      end
    end
  end
end
