# frozen_string_literal: true

require 'test_helper'

module Diplomacy
  class ValidatorTest < Minitest::Test
    def setup
      @validator = Validator.new
    end

    def test_army_hold_on_land
      input = ['A Naf H']
      assert_valid input
    end

    def test_fleet_hold_inland
      input = ['F Mos H']
      refute_valid input
    end

    def test_valid_support
      input = ['F Con S AEG - Bul/sc']
      assert_valid input
    end

    def test_fleet_supporting_onto_land
      input = ['F Con S AEG - Bul']
      assert_valid input
    end

    def test_fleet_supporting_landlocked
      input = ['F Sev S Mos H']
      refute_valid input
    end

    def assert_valid(input)
      assert_predicate(
        @validator.validate(input),
        :success?,
        "Expected #{input} to be valid"
      )
    end

    def refute_valid(input)
      refute_predicate(
        @validator.validate(input),
        :success?,
        "Expected #{input} to be invalid"
      )
    end
  end
end
