module GpxRuby

  module Gpx

    class Parser

      def initialize(input)
        @xml = case input
                 when File
                   input.read
                 when Tempfile
                   input.read
                 when String
                   ::File.open(input, 'r') { |f| f.read }
                 when Hash
                   if input[:file_path] && input[:file_path].is_a?(String)
                   ::File.open(input[:file_path], 'r') { |f| f.read }
                   end
                   if input[:xml] && input[:xml].is_a?(String)
                     input[:xml]
                   elsif input[:file] && (input[:file].is_a?(File) || input[:file].is_a?(Tempfile))
                     input[:file].read
                   else
                     raise 'Error: invalid input!'
                  end
                 else
                   raise 'Error: invalid input!'
               end
      end


      def parse
        doc = Nokogiri::XML(@xml)
        @gpx_node = doc.at_xpath('//xmlns:gpx')

        properties = {
            creator: @gpx_node.at_xpath('@creator').value,
            version: @gpx_node.at_xpath('@version').value.to_f,
            tracks: []
        }

        # parse track elements
        tracks = Parsers::TrackParser.new(@gpx_node).parse
        properties = properties.merge(tracks: tracks)

        Document.new properties
      end


    end

  end

end