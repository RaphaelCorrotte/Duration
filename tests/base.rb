# frozen_string_literal: true

require_relative "../lib/duration"

p Duration.new(365 * 24 * 60 * 60 + 6858).to_s
