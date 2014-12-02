module GpxRuby

  module Gpx

    class Point

      attr_accessor :lat, :lon

      RADIUS_KM = 6371

      def initialize(a_hash)
        @lat = a_hash[:lat]
        @lon = a_hash[:lon]
      end


      def [](index)
        case index
          when 0
            lat
          when 1
            lon
          else
            raise 'Invalid index!'
        end
      end

      def +(a_point)
        nlat = lat + a_point.lat
        nlon = lon + a_point.lon
        Point.new lat: nlat, lon: nlon
      end

      def /(a_scalar)
        nlat = lat / a_scalar.to_f
        nlon = lon / a_scalar.to_f
        Point.new lat: nlat, lon: nlon
      end

      def to_s
        "lat: #{lat}, lon: #{lon}"
      end

      def to_a
        [lat, lon]
      end

      def to_hash
        { lat: lat, lon: lon }
      end

      alias_method :to_h, :to_hash


      def distance(a_point)
        p_point = self
        rad_per_deg, radius_meter = Math::PI/180, RADIUS_KM * 1000

        dlon_rad = (a_point.lon-p_point.lon) * rad_per_deg
        dlat_rad = (a_point.lat-p_point.lat) * rad_per_deg

        lat1_rad = p_point.lat * rad_per_deg
        lat2_rad = a_point.lat * rad_per_deg

        p_point = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
        c = 2 * Math::atan2(Math::sqrt(p_point), Math::sqrt(1-p_point))

        radius_meter * c
      end


    end

  end



end