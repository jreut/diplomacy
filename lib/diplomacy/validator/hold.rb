# frozen_string_literal: true

module Diplomacy
  class Validator
    # Validate a hold order
    class Hold
      include Dry::Monads::Result::Mixin

      def initialize(order:, graph:)
        @order = order
        @graph = graph
      end

      def validate
        if @graph.exist? unit: @order.unit, province: @order.at
          Success @order
        else
          Failure "no #{@order.at} for #{@order.unit}"
        end
      end
    end
  end
end
