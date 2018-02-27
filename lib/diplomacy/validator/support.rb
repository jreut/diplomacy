# frozen_string_literal: true

module Diplomacy
  class Validator
    # Validate a support order
    class Support
      include Dry::Monads::Result::Mixin
      include Dry::Monads::Maybe::Mixin

      def initialize(order:, graph:)
        @graph = graph
        @order = order
      end

      def validate
        if supportable_target?
          result
        else
          Failure "#{@order.target} is not a supportable order"
        end
      end

      private

      def supportable_target?
        @order.target.respond_to? :destination
      end

      def result
        unit = @order.unit
        from = @order.at
        to = @order.target.destination

        if @graph.can_support? unit: unit, from: from, to: to
          Success None
        else
          Failure "Cannot support #{from} to #{to} with #{unit}"
        end
      end
    end
  end
end
