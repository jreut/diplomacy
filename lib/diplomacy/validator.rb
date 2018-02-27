# frozen_string_literal: true

module Diplomacy
  # Produce valid orders from a set of strings
  class Validator
    include Dry::Monads::List::Mixin

    def initialize(parser: Parser.new, graph: Graph.new)
      @parser = parser
      @graph = graph
    end

    def validate(strings)
      List(strings)
        .fmap { |e| @parser.parse e }
        .typed(Dry::Monads::Result)
        .traverse
        .bind do |orders|
          orders
            .map { |e| validate_order e, orders }
            .typed(Dry::Monads::Result)
            .traverse
        end
    end

    private

    def validate_order(order, _rest)
      validator =
        case order
        when Order::Hold
          self.class::Hold.new(order: order, graph: @graph)
        when Order::Support
          self.class::Support.new(order: order, graph: @graph)
        else
          raise "unhandled order #{order.class}"
        end
      validator.validate
    end
  end
end
