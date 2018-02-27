module Diplomacy
  module Order
    class Supported
      class Move # :nodoc:
        include Anima.new :from, :to

        alias destination to

        def to_s
          @to_s ||= "#{from} - #{to}"
        end
      end
    end
  end
end
