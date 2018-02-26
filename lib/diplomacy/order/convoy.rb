module Diplomacy
  module Order
    class Convoy # :nodoc:
      include Anima.new :at, :from, :to

      def unit
        :fleet
      end

      def provinces
        Set.new [at, from, to]
      end
    end
  end
end
