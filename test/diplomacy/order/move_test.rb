# frozen_string_literal: true

require 'test_helper'
require 'role/order'
require 'role/supportable'

module Diplomacy
  module Order
    class MoveTest < Minitest::Test
      include Role::Order
      include Role::Supportable

      def setup
        @subject = Move.new(unit: :fleet, from: 'Bar', to: 'Baz')
      end

      def test_destination_is_to
        assert_equal 'Baz', @subject.destination
      end

      def test_to_s
        assert_equal 'F Bar - Baz', @subject.to_s
      end
    end
  end
end
