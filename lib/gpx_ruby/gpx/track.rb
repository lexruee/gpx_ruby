module GpxRuby

  module Gpx

    class Track

      attr_accessor :segments, :name, :time,
                    :description, :source, :comment,
                    :number, :url, :url_name

      def initialize(a_hash)
        @name = a_hash[:name]
        @time = a_hash[:time]
        @segments = a_hash[:segments] || []
        @number = a_hash[:number]
        @source = a_hash[:source]
        @url = a_hash[:url]
        @url_name = a_hash[:url_name]
        @comment = a_hash[:comment]
        @description = a_hash[:description]
      end

      def points
        @points ||= @segments.map {|segment| segment.points }.reduce(:+)
      end

      def distance
        @distance ||= @segments.map {|segment| segment.distance }.reduce(:+)
      end

      def total_time
        start_time = @segments.first.points.first.time
        end_time = @segments.last.points.last.time
        end_time - start_time rescue 0
      end

      def center_of_gravity
        track_points  = points
        len = track_points.size
        center = track_points.reduce(:+)
        center / len
      end


      class Point < Gpx::Point

        attr_accessor :lat, :lon, :time, :elevation

        def initialize(params)
          @lat = params[:lat]
          @lon = params[:lon]
          @time = params[:time]
          @elevation = params[:elevation]
        end

        def to_a
          [@lat,@lon]
        end

      end


      class Segment

        attr_accessor :points

        def initialize(points)
          @points = points || []
        end

        def distance
          if @distance
            @distance
          else
            zipped_points = @points[0...-1].zip(@points[1..-1])
            distances = zipped_points.map {|(p,q)| p.distance(q) }
            @distance = distances.reduce(:+)
          end
        end

        def total_time
          start_time, end_time = @points.first.time, @points.last.time
          end_time - start_time rescue 0
        end

        def center_of_gravity
          track_points  = points
          len = track_points.size
          center = track_points.reduce(:+)
          center / len
        end

      end

    end

  end


end