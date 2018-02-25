module Diplomacy
  module Order
    class Move # :nodoc:
      include Anima.new :unit, :from, :to
    end
  end
end
