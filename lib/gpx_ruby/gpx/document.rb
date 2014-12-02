module GpxRuby

  module Gpx

    class Document

      attr_accessor :version, :creator, :tracks

      def initialize(a_hash)
        @creator = a_hash[:creator]
        @version = a_hash[:version]
        @tracks = a_hash[:tracks]
      end

    end

  end

end