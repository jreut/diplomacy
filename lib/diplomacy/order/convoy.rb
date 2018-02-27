# frozen_string_literal: true

module Diplomacy
  module Order
    class Convoy # :nodoc:
      include Anima.new :at, :from, :to

      def unit
        @unit ||= :fleet
      end

      def to_s
        @to_s ||= "F #{at} C #{from} - #{to}"
      end
    end
  end
end
