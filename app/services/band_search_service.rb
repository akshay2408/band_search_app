require 'httparty'

class BandSearchService
  MUSICBRAINZ_API_URL = "https://musicbrainz.org/ws/2/artist"

  class << self
    def get_bands_by_location(city)
      bands = fetch_bands_by_location(city)
      filter_recent_bands(bands)
    rescue StandardError => e
      log_error(e, "Failed to fetch bands for location: #{city}")
      raise
    end

    def get_user_location
      location = fetch_user_location
      location == 'Unknown' ? nil : location
    rescue StandardError => e
      log_error(e, "Failed to fetch user location")
      raise
    end

    private

    def fetch_bands_by_location(city)
      url = build_musicbrainz_url(city)
      response = HTTParty.get(url, headers: { "User-Agent" => "band_finder_app/1.0 (useremail@example.com)" })
      return [] unless response.success?

      response.parsed_response['artists'].first(50)
    rescue HTTParty::Error => e
      log_error(e, "Error fetching data from MusicBrainz API for city: #{city}")
      []
    end

    def build_musicbrainz_url(city)
      "#{MUSICBRAINZ_API_URL}?query=area:#{city}&fmt=json"
    end

    def filter_recent_bands(bands)
      bands.select do |band|
        formation_date = band.dig('life-span', 'begin')
        formation_date && formation_date.to_i >= (Time.now.year - 1000)
      end
    end

    def fetch_user_location
      response = HTTParty.get('https://get.geojs.io/v1/ip/geo.json')
      location = response.parsed_response
      location['city']
    rescue HTTParty::Error => e
      log_error(e, "Error fetching user location from geojs.io")
      raise StandardError, 'Unable to determine user location'
    end

    def log_error(exception, message)
      Rails.logger.error("#{message}: #{exception.message}")
    end
  end
end
