module GpxRuby

require 'nokogiri'
require 'time'
require 'tempfile'
require 'gpx_ruby/gpx/point'
require 'gpx_ruby/gpx/track'
require 'gpx_ruby/gpx/parsers/track_parser'
require 'gpx_ruby/gpx/document'
require 'gpx_ruby/gpx/parser'

  class << self

    def File(input)
      Gpx::Parser.new(input).parse
    end

  end

end