module Diplomacy
  module Order
    class Hold # :nodoc:
      include Anima.new :unit, :at

      def provinces
        Set.new [at]
      end
    end
  end
end
