require_relative "config"

module BrandRotator
  class Theme
    class << self
      def today
        now = DateTime.now
        today = DateTime.new(now.year, now.month, now.day)
        seconds_since_epoch = today.to_time.to_i
        days_since_epoch = seconds_since_epoch / (60 * 60 * 24)

        index_for_today = days_since_epoch % Config::THEMES.count

        Config::THEMES[index_for_today]
      end
    end
  end
end
