require 'test_helper'

module Diplomacy
  class ParserTest < Minitest::Test
    def setup
      @parser = Diplomacy::Parser.new
    end

    def test_parse_army_move_order
      input = 'A Abc - Def'
      result = @parser.parse input
      assert_result_equal(
        Order::Move.new(unit: :army, from: 'Abc', to: 'Def'),
        result
      )
    end

    def test_parse_move_with_arrow
      input = 'A Foo -> Bar'
      result = @parser.parse input
      assert_result_equal(
        Order::Move.new(unit: :army, from: 'Foo', to: 'Bar'),
        result
      )
    end

    def test_parse_fleet_move
      input = 'F Bre - Pic'
      result = @parser.parse input
      assert_result_equal(
        Order::Move.new(unit: :fleet, from: 'Bre', to: 'Pic'),
        result
      )
    end

    def test_parse_army_support
      input = 'A Ruh S Pic - Bel'
      expected = Order::Support.new(
        unit: :army,
        at: 'Ruh',
        target: Order::Supported::Move.new(from: 'Pic', to: 'Bel')
      )
      assert_result_equal expected, @parser.parse(input)
    end

    def test_parse_hold
      input = 'F AEG H'
      expected = Order::Hold.new(unit: :fleet, at: 'AEG')
      assert_result_equal expected, @parser.parse(input)
    end

    def test_parse_support_of_hold
      input = 'A Swe S Nwy H'
      assert_result_equal(
        Order::Support.new(
          unit: :army,
          at: 'Swe',
          target: Order::Supported::Hold.new(at: 'Nwy')
        ),
        @parser.parse(input)
      )
    end

    def test_parse_fails_without_unit
      input = 'Sev - Mos'
      assert_failure_message(/unit/, @parser.parse(input))
    end

    def test_parse_fleet_on_coast
      input = 'F BAR - Stp/nc'
      assert_result_equal(
        Order::Move.new(unit: :fleet, from: 'BAR', to: 'Stp/nc'),
        @parser.parse(input)
      )
    end

    def test_convoy
      input = 'F NTH C Bel - Lon'
      assert_result_equal(
        Order::Convoy.new(at: 'NTH', from: 'Bel', to: 'Lon'),
        @parser.parse(input)
      )
    end

    def assert_result_equal(expected, result, msg = nil)
      result
        .fmap { |actual| assert_equal expected, actual }
        .or { |failure| flunk(msg || failure) }
    end

    def assert_failure_message(matcher, result)
      result
        .fmap { |value| flunk "got #{value} instead of failure" }
        .or { |failure| assert_match matcher, failure }
    end
  end
end
