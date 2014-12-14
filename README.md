#GpxRuby
GpxRuby is a simple a Gpx file reader which is not yet finished (version 0.1.0).

Currently GpxRuby only parses track elements of a gpx file all the other elements are not considered.

##Install
```
gem install gpx_ruby
```

##Reading gpx files
```ruby
require 'gpx_ruby'

# read a gpx file
gpx_file = GpxRuby::File './my_gpx_file.gpx'
puts gpx_file.creator
puts gpx_file.version

#list all tracks
puts gpx.tracks

#get first track
track = gpx.tracks.first

#compute total distance
track.distance

#list all points of a track
puts track.points

#list all segments of a track
puts track.segments

#list all points of a segment
segment = track.segments.first
puts segment.points

#get a single point
track.points.first
track.points[0]

segment.points.first
segment.points[0]

#get lat / lon
point = track.points.first
puts point.lat
puts point.lon
puts point.to_a #get array [lat,lon]
puts point.to_h #get hash { lat: lat, lon: lon }

#compute total distance
segment.distance

#get center of gravity
puts segment.center_of_gravity
puts track.center_of_gravity

```
##Chnagelog
###0.1.0
- Publish GpxRuby gem under gpx_ruby.
- Add XML class method to GpxRuby module.
- Support hash as valid input for GpxRuby::Parser with options: :file, :xml, :file_path
###0.0.0
Publish first draft.