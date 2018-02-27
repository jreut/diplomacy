module Diplomacy
  module Order
    class Move # :nodoc:
      include Anima.new :unit, :from, :to

      alias destination to

      def unit
        @unit || '?'
      end

      def to_s
        @to_s ||= "#{unit.to_s[0].upcase} #{from} - #{to}"
      end
    end
  end
end
