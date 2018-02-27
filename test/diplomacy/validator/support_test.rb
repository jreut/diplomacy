# frozen_string_literal: true

require 'test_helper'

module Diplomacy
  class Validator
    class SupportTest < Minitest::Test
      def setup
        @graph = Graph.new
      end

      def test_fleet_support_sea_to_coast
        assert_valid(
          Order::Support.new(
            unit: :fleet,
            at: 'Con',
            target: Order::Supported::Move.new(
              from: 'AEG',
              to: 'Bul/sc'
            )
          )
        )
      end

      def test_fleet_supporting_sea_to_land
        assert_valid(
          Order::Support.new(
            unit: :fleet,
            at: 'Con',
            target: Order::Supported::Move.new(
              from: 'AEG',
              to: 'Bul'
            )
          )
        )
      end

      def test_fleet_supporting_landlocked
        refute_valid(
          Order::Support.new(
            unit: :fleet,
            at: 'Sev/sc',
            target: Order::Supported::Hold.new(at: 'Mos')
          )
        )
      end

      def test_army_fleet_coming_ashore
        assert_valid(
          Order::Support.new(
            unit: :army,
            at: 'Bul',
            target: Order::Supported::Move.new(
              from: 'BLA',
              to: 'Rum'
            )
          )
        )
      end

      def assert_valid(order)
        if validate(order).success?
          pass
        else
          flunk "Expected #{order} to be valid"
        end
      end

      def refute_valid(order)
        if validate(order).failure?
          pass
        else
          flunk "Expected #{order} to be invalid"
        end
      end

      def validate(order)
        Validator::Support.new(order: order, graph: @graph).validate
      end
    end
  end
end
