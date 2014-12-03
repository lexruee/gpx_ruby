require 'test/test_helper'

class TestGpxParser < MiniTest::Test

  def setup
    @gpx_parser = GpxRuby::Gpx::Parser.new './test/run_keeper.gpx'
    @gpx_file = @gpx_parser.parse
  end

  def test_should_read_gpx_file
    gpx_parser = GpxRuby::Gpx::Parser.new File.open('./test/run_keeper.gpx','r')
    gpx_file = gpx_parser.parse
    assert gpx_file.creator
    assert gpx_file.version
  end


  def test_should_read_gpx_temp_file
    xml = File.open('./test/run_keeper.gpx','r') { |f| f.read }
    tmp_file = Tempfile.open('blah.gpx')
    tmp_file.write xml
    tmp_file.rewind
    gpx_parser = GpxRuby::Gpx::Parser.new tmp_file
    gpx_file = gpx_parser.parse
    assert gpx_file.creator
    assert gpx_file.version
  end


  def test_should_read_file_path
    gpx_parser = GpxRuby::Gpx::Parser.new './test/run_keeper.gpx'
    gpx_file = gpx_parser.parse
    assert gpx_file.creator
    assert gpx_file.version
  end


  def test_should_read_gpx_xml
    xml = File.open('./test/run_keeper.gpx') do |f|
      f.read
    end
    gpx_parser = GpxRuby::Gpx::Parser.new xml: xml
    gpx_file = gpx_parser.parse
    assert gpx_file.creator
    assert gpx_file.version
  end


  def test_should_read_gpx_xml_using_a_shortcut
    xml = File.open('./test/run_keeper.gpx') do |f|
      f.read
    end
    gpx_file = GpxRuby::XML(xml)
    assert gpx_file.creator
    assert gpx_file.version
  end


  def test_should_read_gpx_file_using_a_shortcut
    gpx_file = GpxRuby::File './test/run_keeper.gpx'
    assert gpx_file.creator
    assert gpx_file.version
  end


  def test_should_compute_center_of_gravity
    gpx_parser = GpxRuby::Gpx::Parser.new './test/run_keeper.gpx'
    gpx_file = gpx_parser.parse
    track = gpx_file.tracks.first
    pp 'center of gravity: %s' % track.center_of_gravity
  end


  def test_should_read_fell_loops
    gpx_file = GpxRuby::File './test/gpx_samples/fells_loop.gpx'
    assert gpx_file.creator
    assert gpx_file.version
    track = gpx_file.tracks.first
    assert track.nil?
    gpx_file.tracks.each  do |track|
      assert track.name || track.name.nil?
      assert track.time || track.time.nil?
      assert track.distance
    end
  end


  def test_should_read_boise_front
    gpx_file = GpxRuby.File './test/gpx_samples/BoiseFront.gpx'
    assert gpx_file.creator
    assert gpx_file.version
    track = gpx_file.tracks.first
    assert track.nil? == false
    assert track.total_time == 0
    gpx_file.tracks.each  do |track|
      assert track.name || track.name.nil?
      assert track.time || track.time.nil?
      assert track.distance
    end
  end


  def test_should_read_track
    track = @gpx_file.tracks.first
    assert track
    assert track.is_a? GpxRuby::Gpx::Track
  end


  def test_should_read_track_segments
    track = @gpx_file.tracks.first
    track_segments = track.segments
    assert track_segments.size == 4
  end


  def test_should_read_track_segment_points
    track = @gpx_file.tracks.first
    track_segment = track.segments.last
    assert track_segment.points.size > 0
    track_points = track_segment.points
    track_points.each do |track_point|
      assert track_point.lat
      assert track_point.lon
      assert track_point.elevation
    end

  end


  def test_should_read_track_points
    track = @gpx_file.tracks.first
    assert track
    assert track.points.size > 0
    track_points = track.points
    track_points.each do |track_point|
      assert track_point.lat
      assert track_point.lon
      assert track_point.elevation
    end
  end


  def test_should_compute_total_track_segment_distance
    track = @gpx_file.tracks.first
    puts track.segments.map {|segment| segment.distance }
  end


  def test_should_compute_total_track_distance
    track = @gpx_file.tracks.first
    puts track.distance
  end


  def test_should_compute_total_track_time
    track = @gpx_file.tracks.first
    puts track.total_time
  end


  def test_should_compute_total_segment_time
    track = @gpx_file.tracks.first
    puts track.segments.map {|segment| segment.total_time }
  end

end