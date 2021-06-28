# frozen_string_literal: false

require "time"
require "date"
require_relative "comparable"

class CoolDuration
  include Duration::Comparable
  attr_reader :duration_hash

  # @param [Integer] timestamp
  def initialize(timestamp, language: en)
    I18n.locale = language

    seconds = Time.strptime(timestamp.to_s, "%s").to_i
    minutes, seconds_left, hours, minutes_left, days, hours_left, days_left, years = [0] * 8

    minutes, seconds_left = seconds.divmod(60) if seconds >= 60
    hours, minutes_left = minutes.divmod(60) if minutes >= 60
    days, hours_left = hours.divmod(24) if hours >= 24
    years, days_left = days.divmod(365) if days >= 365

    seconds_left = seconds if seconds < 60
    minutes_left = minutes if minutes < 60
    hours_left = hours if hours < 24
    days_left = days if days < 365

    @duration_hash = Hash[
      :seconds => Hash[
        :total => seconds,
        :left => seconds_left
      ],
      :minutes => Hash[
        :total => minutes,
        :left => minutes_left
      ],
      :hours => Hash[
        :total => hours,
        :left => hours_left
      ],
      :days => Hash[
        :total => days,
        :left => days_left
      ],
      :years => Hash[
        :total => years,
        :left => years
      ]
    ].freeze
  end

  # Return the duration as string
  # @return [String] the stringed duration
  def to_s
    valid = []
    @duration_hash.each do |unity, values|
      p values
      next if values[:left]&.zero?

      plural = values[:left] > 1
      to_push = plural ? unity : unity.to_s.delete_suffix("s").to_sym

      valid << to_push
    end
    valid.reverse!

    valid.each_with_index do |element, index|
      valid[index] = I18n.t(element,
                            :scope => "duration_strings",
                            :"#{element[element.size - 1] == "s" ? element : "#{element}s"}" => @duration_hash[:"#{element[element.size - 1] == "s" ? element : "#{element}s"}"][:left])
    end
    return [valid.slice(0, valid.size - 1).join(", "), valid.slice(-1)].join(" #{I18n.t(:and)} ") if valid.size > 1

    valid.join("") if valid.size == 1
  end

  def to_i
    @duration_hash[:seconds][:total]
  end
end
