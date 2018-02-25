module Diplomacy
  module Order
    class Support # :nodoc:
      include Anima.new :unit, :at, :order

      def provinces
        Set.new [at, *order.provinces]
      end
    end
  end
end
