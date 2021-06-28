# frozen_string_literal: true

module Duration
  module Comparable
    # Know if other is a Duration
    # @param [Duration] other
    def duration?(other)
      other.is_a?(CoolDuration)
    end

    # Know if other is higher than the current class
    # @param [Duration] other
    def >(other)
      return nil unless duration?(other)

      to_i > other.to_i
    end

    def <=>(other)
      return nil unless duration?(other)

      to_i <=> other.to_i
    end
  end
end
