#!/usr/bin/env ruby

require_relative 'gis'
require_relative 'geojson'

def main()
  homeWaypoint = Waypoint.new(-121.5, 45.5, elevation: 30, name: "home", iconType: "flag")
  storeWaypoint = Waypoint.new(-121.5, 45.6, name: "store")

  trackSegment1 = TrackSegment.new([
    Waypoint.new(-122, 45),
    Waypoint.new(-122, 46),
    Waypoint.new(-121, 46)
  ])

  trackSegment2 = TrackSegment.new([
    Waypoint.new(-121, 45),
    Waypoint.new(-121, 46)
  ])

  trackSegment3 = TrackSegment.new([
    Waypoint.new(-121, 45.5),
    Waypoint.new(-122, 45.5)
  ])

  track1 = Track.new([trackSegment1, trackSegment2], "track 1")
  track2 = Track.new([trackSegment3], "track 2")

  myDataSet = FeatureSet.new("My Data", [homeWaypoint, storeWaypoint, track1, track2])
  geoJSON = GEOJSON.new()

  puts geoJSON.assemble_geojson(myDataSet)
end


if File.identical?(__FILE__, $0)
  main()
end
