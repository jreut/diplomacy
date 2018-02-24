require 'test_helper'

class DataTest < Minitest::Test
  def test_there_are_34_supply_centers
    data = load_yaml 'supply_centers'
    assert_equal 34, data.size
  end

  def test_fleet_graph
    assert_complete_graph 'fleet_graph'
  end

  def test_army_graph
    assert_complete_graph 'army_graph'
  end

  def assert_complete_graph(name)
    data = load_yaml name
    data.each_key do |a|
      data[a].each do |b|
        assert_includes data.keys, a, "need a top level key for #{a}"
        assert_includes data[a], b, "#{a} is missing a connection to #{b}"
        assert_includes data.keys, b, "need a top level key for #{b}"
        assert_includes data[b], a, "#{b} is missing a connection to #{a}"
      end
    end
  end
end
