# frozen_string_literal: true

module Diplomacy
  module Order
    class Hold # :nodoc:
      include Anima.new :unit, :at

      alias destination at

      def unit
        @unit || '?'
      end

      def to_s
        @to_s ||= "#{unit.to_s[0].upcase} #{at} H"
      end
    end
  end
end
