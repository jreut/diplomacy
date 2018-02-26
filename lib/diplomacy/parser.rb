module Diplomacy
  # Parse strings into orders
  class Parser
    include Dry::Monads::Result::Mixin

    PROVINCE = %r{[[:alpha:]]{3}(?:/\w+)?}

    def parse(input)
      parse_internal input, has_unit: true
    end

    private

    # rubocop:disable Metrics/MethodLength
    def parse_internal(input, has_unit:)
      parse_order_type(input).bind do |type|
        case type
        when :move
          parse_move(input, has_unit: has_unit)
        when :support
          parse_support(input)
        when :hold
          parse_hold(input, has_unit: has_unit)
        when :convoy
          parse_convoy(input)
        else
          Failure "unhandled type '#{type}'"
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    def parse_hold(input, has_unit:)
      at = input.match(PROVINCE)[0]
      if has_unit
        parse_unit(input).fmap do |unit|
          Order::Hold.new unit: unit, at: at
        end
      else
        Order::Hold.new unit: nil, at: at
      end
    end

    def parse_move(input, has_unit:)
      from, to = input.scan(PROVINCE)
      if has_unit
        parse_unit(input).fmap do |unit|
          Order::Move.new unit: unit, from: from, to: to
        end
      else
        Order::Move.new unit: nil, from: from, to: to
      end
    end

    def parse_support(input)
      parse_unit(input).fmap do |unit|
        head, rest = input.split(/\bS\b/)
        at = head.match(PROVINCE)[0]
        order = parse_internal(rest, has_unit: false)
        Order::Support.new(unit: unit, at: at, order: order)
      end
    end

    def parse_convoy(input)
      at, from, to = input.scan(PROVINCE)
      Success Order::Convoy.new(at: at, from: from, to: to)
    end

    def parse_unit(input)
      case input[0].upcase
      when 'A'
        Success :army
      when 'F'
        Success :fleet
      else
        Failure "unknown unit #{input[0]}"
      end
    end

    def parse_order_type(input)
      if input =~ /\bS\b/
        Success :support
      elsif input =~ /\bH\b/
        Success :hold
      elsif input =~ /\bC\b/
        Success :convoy
      else
        Success :move
      end
    end

    def to_and_from(input)
      Success input.scan(PROVINCE)
    end
  end
end
