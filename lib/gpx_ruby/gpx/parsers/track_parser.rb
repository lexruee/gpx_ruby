module GpxRuby

  module Gpx

    module Parsers

      class TrackParser

        def initialize(gpx_node)
          @gpx_node = gpx_node
        end

        def parse
          tracks = []
          if track_nodes = @gpx_node.xpath('./xmlns:trk')
            # iterate over all tracks
            track_nodes.each do |trk|
              trk_segments = trk.xpath('./xmlns:trkseg')

              # map track segments for this track
              track_segments = trk_segments.map do |trkseg|

                # map all track points for this track segment
                track_points = trkseg.xpath('./xmlns:trkpt').map do |trkpt|

                  lat = trkpt.at_xpath('./@lat').value.to_f
                  lon = trkpt.at_xpath('./@lon').value.to_f

                  time = begin
                    DateTime.xmlschema(trkpt.at_xpath('./xmlns:time').text).to_time
                  rescue
                    nil
                  end

                  elevation =  begin
                    trkpt.at_xpath('./xmlns:ele').text.to_f
                  rescue
                    nil
                  end

                  Track::Point.new lat: lat, lon: lon, time: time, elevation: elevation
                end

                Track::Segment.new track_points
              end

              trk_name = begin
                trk.at_xpath('./xmlns:name').text
              rescue
                nil
              end

              trk_cmt = begin
                trk.at_xpath('./xmlns:cmt').text
              rescue
                nil
              end

              trk_src = begin
                trk.at_xpath('./xmlns:src').text
              rescue
                nil
              end

              trk_desc = begin
                trk.at_xpath('./xmlns:desc').text
              rescue
                nil
              end

              trk_number = begin
                trk.at_xpath('./xmlns:number').text
              rescue
                nil
              end

              trk_url = begin
                trk.at_xpath('./xmlns:url').text
              rescue
                nil
              end

              trk_url_name = begin
                trk.at_xpath('./xmlns:urlname').text
              rescue
                nil
              end

              trk_time = begin
                DateTime.xmlschema(trk.at_xpath('./xmlns:time').text).to_time
              rescue
                nil
              end

              track_hash = {
                  segments: track_segments,
                  name: trk_name,
                  time: trk_time,
                  source: trk_src,
                  description: trk_desc,
                  number: trk_number,
                  comment: trk_cmt,
                  url: trk_url,
                  url_name: trk_url_name
              }

              tracks << Track.new(track_hash)
            end

          end

          tracks
        end

      end

    end

  end

end