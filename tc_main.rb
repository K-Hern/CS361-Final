require_relative 'geojson.rb'
require_relative 'gis.rb'
require 'test/unit'

class TestMainGeoJSON < Test::Unit::TestCase

  # This file tests the given main function against the given example within the README.md
  def test_main
    homeWaypoint = Waypoint.new(-121.5, 45.5, elevation: 30, name: "home", iconType: "flag")
    storeWaypoint = Waypoint.new(-121.5, 45.6, iconType: "dot", name: "store")

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

    # This retrieved directly and unaltered from the README example, merely de-beautified
    expected = '{"type":"FeatureCollection","features":[{"type":"Feature","properties":{"title":"home","icon":"flag"},"geometry":{"type":"Point","coordinates":[-121.5,45.5,30]}},{"type":"Feature","properties":{"title":"store","icon":"dot"},"geometry":{"type":"Point","coordinates":[-121.5,45.6]}},{"type":"Feature","properties":{"title":"track 1"},"geometry":{"type":"MultiLineString","coordinates":[[[-122,45],[-122,46],[-121,46]],[[-121,45],[-121,46]]]}},{"type":"Feature","properties":{"title":"track 2"},"geometry":{"type":"MultiLineString","coordinates":[[[-121,45.5],[-122,45.5]]]}}]}'
    assert_equal(expected, geoJSON.assemble_geojson(myDataSet))
  end

end
