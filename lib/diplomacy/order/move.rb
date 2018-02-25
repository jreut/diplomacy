module Diplomacy
  module Order
    class Move # :nodoc:
      include Anima.new :unit, :from, :to

      def provinces
        Set.new [from, to]
      end
    end
  end
end
