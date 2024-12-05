#!/usr/bin/env ruby

class Track
  attr_accessor :name, :trackSegmentObjs

  def initialize(trackSegmentObjs, name=nil)
    @name = name
    @trackSegmentObjs = trackSegmentObjs
  end

  def add_segment(newTrackObj)
    self.trackSegmentObjs << newTrackObj
  end

  def remove_segment(trackObj)
    self.trackSegmentObjs.remove(trackObj)
  end
end

class TrackSegment
  attr_reader :coordinates

  def initialize(coordinates)
    @coordinates = coordinates
  end
end

class Waypoint
attr_reader :latitude, :longitude, :elevation, :name, :icon_type

  def initialize(longitude, latitude, elevation=nil, name=nil, icon_type=nil)
    @latitude = latitude
    @longitude = longitude
    @elevation = elevation
    @name = name
    @icon_type = icon_type
  end
end

class GEOJSON
  attr_accessor :featureSetName, :featureSet

  def initialize(featureSetName, featureSet)
    @featureSetName = featureSetName
    @featureSet = featureSet
  end
end

def main()
  homeWaypoint = Waypoint.new(-121.5, 45.5, 30, "home", "flag")
  storeWaypoint = Waypoint.new(-121.5, 45.6, nil, "store", "dot")

  trackSegment1 = [
    Waypoint.new(-122, 45),
    Waypoint.new(-122, 46),
    Waypoint.new(-121, 46)
  ]

  trackSegment2 = [
    Waypoint.new(-121, 45),
    Waypoint.new(-121, 46)
  ]

  trackSegment3 = [
    Waypoint.new(-121, 45.5),
    Waypoint.new(-122, 45.5)
  ]

  track1 = Track.new([trackSegment1, trackSegment2], "track 1")
  track2 = Track.new([trackSegment3], "track 2")

  geoJSON = GEOJSON.new("My Data", [homeWaypoint, storeWaypoint, track1, track2])

  puts geoJSON.create_geojson()
end

if File.identical?(__FILE__, $0)
  main()
end
