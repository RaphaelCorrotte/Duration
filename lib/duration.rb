# frozen_string_literal: true

require_relative "duration/version"
require_relative "duration/rubydate"

module Duration
  def self.new(date)
    ParentRubydate::RubyDate.new(date)
  end
end
