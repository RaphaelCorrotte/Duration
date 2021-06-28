# frozen_string_literal: true

require_relative "duration/version"
require_relative "duration/cool_duration"
require "i18n"

I18n.load_path << Dir["#{File.expand_path("config/locales")}/en.yml"]

module Duration
  def self.new(timestamp)
    CoolDuration.new(timestamp)
  end
end
