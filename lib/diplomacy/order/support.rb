module Diplomacy
  module Order
    class Support # :nodoc:
      include Anima.new :unit, :at, :target

      def to_s
        @to_s ||= "#{unit.to_s[0].upcase} #{at} S #{target}"
      end
    end
  end
end
