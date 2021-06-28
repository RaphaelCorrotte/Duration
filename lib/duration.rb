# frozen_string_literal: true

require_relative "duration/version"
require_relative "duration/cool_duration"
require "i18n"

I18n.load_path << Dir["#{File.expand_path("config/locales")}/en.yml"]
I18n.load_path << Dir["#{File.expand_path("config/locales")}/fr.yml"]

I18n.available_locales = %i[en fr]

module Duration
  def self.new(timestamp, language: :en)
    CoolDuration.new(timestamp, :language => language)
  end
end
