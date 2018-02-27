module Diplomacy
  module Order
    class Supported
      class Hold # :nodoc:
        include Anima.new :at

        alias destination at

        def to_s
          @to_s ||= "#{at} H"
        end
      end
    end
  end
end
