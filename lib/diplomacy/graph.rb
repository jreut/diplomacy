

# frozen_string_literal: true

module Diplomacy
  # Connections among the provinces of a Diplomacy board
  class Graph
    def initialize
      data_dir = Pathname.new(__dir__).parent.parent.join('data')
      @data = {
        army: YAML.safe_load(data_dir.join('army_graph.yml').open),
        fleet: YAML.safe_load(data_dir.join('fleet_graph.yml').open)
      }
    end

    def can_move?(unit:, edge:)
      first, second = edge.to_a
      @data[unit].fetch(first, []).include?(second)
    end

    def can_support?(unit:, from:, to:)
      return false unless exist? unit: unit, province: from
      @data[unit]
        .fetch(from, [])
        .map { |s| strip_coast s }
        .include? strip_coast(to)
    end

    def can_convoy?(edge:, fleets:)
      from, to = edge.map do |province|
        @data[:fleet].find { |k, _| strip_coast(k) == province }.first
      end
      convoy_rec(
        goal: to,
        current: from,
        rest: fleets.intersection(ocean_provinces)
      ).any?
    end

    def exist?(unit:, province:)
      @data[unit].key? province
    end

    private

    def convoy_rec(goal:, current:, rest:)
      possibles = @data[:fleet][current]
      return [true] if possibles.include? goal
      possible_fleets = possibles.to_set.intersection(rest)
      possible_fleets.flat_map do |fleet|
        convoy_rec goal: goal, current: fleet, rest: rest.dup.delete(fleet)
      end
    end

    def strip_coast(string)
      string.split('/').first
    end

    def ocean_provinces
      @ocean_provinces ||= @data[:fleet].keys.select { |k| k == k.upcase }
    end
  end
end
