# frozen_string_literal: true

require 'test_helper'

module Diplomacy
  class GraphTest < Minitest::Test
    def setup
      @graph = Graph.new
    end

    def test_adjacent_army_provinces_are_can_move
      assert_move :army, 'Stp', 'Nwy'
    end

    def test_disparate_army_provinces_are_not_can_move
      refute_move :army, 'Lon', 'Bel'
    end

    def test_army_cannot_move_into_sea
      refute_move :army, 'Lon', 'NTH'
    end

    def test_army_cannot_move_into_coast
      refute_move :army, 'Nwy', 'Stp/nc'
    end

    def test_army_can_support_all_coasts_of_adjacent_province
      assert_support :army, 'Nwy', 'Stp/nc'
      assert_support :army, 'Nwy', 'Stp/sc'
    end

    def test_fleet_can_support_adjacent_coastal_province
      assert_support :fleet, 'Nwy', 'Stp'
    end

    def test_army_cannot_support_sea
      refute_support :army, 'Lon', 'NTH'
    end

    def test_fleet_can_support_sea
      assert_support :fleet, 'Spa/nc', 'MAO'
    end

    def test_can_convoy_from_ocean
      assert_convoy 'Lon', 'Bel', 'NTH'
    end

    def test_cannot_convoy_from_coast
      refute_convoy 'Bel', 'Kie', 'Hol'
    end

    def test_cannot_convoy_disconnected
      refute_convoy 'Lvp', 'Bel', 'IRI'
    end

    def test_can_convoy_in_a_chain
      assert_convoy 'Wal', 'Pie', 'IRI', 'MAO', 'WES', 'LYO'
    end

    def test_cannot_convoy_a_broken_chain
      refute_convoy 'Wal', 'Pie', 'IRI', 'MAO', 'LYO'
    end

    def test_cannot_convoy_a_chain_including_a_coast
      refute_convoy 'Yor', 'Stp', 'Nwy', 'NTH'
    end

    def test_can_convoy_a_chain_with_a_coast_and_a_valid_path
      assert_convoy 'Yor', 'Stp', 'Nwy', 'NTH', 'NWG', 'BAR'
    end

    def test_exist_works
      assert @graph.exist? unit: :army, province: 'Bel'
    end

    def test_exists_false_for_fleet_in_landlocked_province
      refute @graph.exist? unit: :fleet, province: 'Mos'
    end

    def assert_move(unit, *nodes)
      assert(
        @graph.can_move?(unit: unit, edge: Set.new(nodes)),
        "Expected #{unit} to move between #{nodes.join(' and ')}"
      )
    end

    def refute_move(unit, *nodes)
      refute(
        @graph.can_move?(unit: unit, edge: Set.new(nodes)),
        "Expected #{unit} not to move between #{nodes.join(' and ')}"
      )
    end

    def assert_support(unit, from, to)
      assert(
        @graph.can_support?(unit: unit, from: from, to: to),
        "Expected #{unit} at #{from} to support #{to}"
      )
    end

    def refute_support(unit, from, to)
      refute(
        @graph.can_support?(unit: unit, from: from, to: to),
        "Expected #{unit} at #{from} not to support #{to}"
      )
    end

    def assert_convoy(from, to, *fleets)
      assert(
        @graph.can_convoy?(edge: Set.new([from, to]), fleets: Set.new(fleets)),
        "Expected convoy from #{from} via #{fleets} to #{to}"
      )
    end

    def refute_convoy(from, to, *fleets)
      refute(
        @graph.can_convoy?(edge: Set.new([from, to]), fleets: Set.new(fleets)),
        "Expected no convoy from #{from} via #{fleets} to #{to}"
      )
    end
  end
end
