require_relative 'geojson.rb'
require_relative 'gis.rb'
require 'json'
require 'test/unit'

class TestGeoJSON < Test::Unit::TestCase

  @@geoJSON = GEOJSON.new()

  def test_waypoints
    w = Waypoint.new(-121.5, 45.5, elevation: 30, name: "home", iconType: "flag")
    expected = JSON.parse('{"type": "Feature","properties": {"title": "home","icon": "flag"},"geometry": {"type": "Point","coordinates": [-121.5,45.5,30]}}')
    result = JSON.parse(@@geoJSON.assemble_feature_geojson(w))

    assert_equal(result, expected)

    w = Waypoint.new(-121.5, 45.5, iconType: "flag")
    expected = JSON.parse('{"type": "Feature","properties": {"icon": "flag"},"geometry": {"type": "Point","coordinates": [-121.5,45.5]}}')
    result = JSON.parse(@@geoJSON.assemble_feature_geojson(w))
    assert_equal(result, expected)

    w = Waypoint.new(-121.5, 45.5, name: "store")
    expected = JSON.parse('{"type": "Feature","properties": {"title": "store"},"geometry": {"type": "Point","coordinates": [-121.5,45.5]}}')
    result = JSON.parse(@@geoJSON.assemble_feature_geojson(w))
    assert_equal(result, expected)
  end

  def test_tracks
    ts1 = TrackSegment.new([
      Waypoint.new(-122, 45),
      Waypoint.new(-122, 46),
      Waypoint.new(-121, 46),
    ])

    ts2 = TrackSegment.new([
      Waypoint.new(-121, 45),
      Waypoint.new(-121, 46)
    ])

    ts3 = TrackSegment.new([
      Waypoint.new(-121, 45.5),
      Waypoint.new(-122, 45.5)
    ])

    t = Track.new([ts1, ts2], "track 1")

    expected = JSON.parse('{"type": "Feature", "properties": {"title": "track 1"},"geometry": {"type": "MultiLineString","coordinates": [[[-122,45],[-122,46],[-121,46]],[[-121,45],[-121,46]]]}}')
    result = JSON.parse(@@geoJSON.assemble_feature_geojson(t))
    assert_equal(expected, result)

    t = Track.new([ts3], "track 2")

    expected = JSON.parse('{"type": "Feature", "properties": {"title": "track 2"},"geometry": {"type": "MultiLineString","coordinates": [[[-121,45.5],[-122,45.5]]]}}')
    result = JSON.parse(@@geoJSON.assemble_feature_geojson(t))
    assert_equal(expected, result)
  end

  def test_FeatureSet
    w = Waypoint.new(-121.5, 45.5, elevation: 30, name: "home", iconType: "flag")
    w2 = Waypoint.new(-121.5, 45.6, name: "store", iconType: "dot")

    ts1 = TrackSegment.new([
      Waypoint.new(-122, 45),
      Waypoint.new(-122, 46),
      Waypoint.new(-121, 46)
    ])

    ts2 = TrackSegment.new([ Waypoint.new(-121, 45), Waypoint.new(-121, 46)])

    ts3 = TrackSegment.new([
      Waypoint.new(-121, 45.5),
      Waypoint.new(-122, 45.5)
    ])

    t = Track.new([ts1, ts2], "track 1")
    t2 = Track.new([ts3], "track 2")

    w = FeatureSet.new("My Data", [w, w2, t, t2])

    expected = JSON.parse('{"type": "FeatureCollection","features": [{"type": "Feature","properties": {"title": "home","icon": "flag"},"geometry": {"type": "Point","coordinates": [-121.5,45.5,30]}},{"type": "Feature","properties": {"title": "store","icon": "dot"},"geometry": {"type": "Point","coordinates": [-121.5,45.6]}},{"type": "Feature", "properties": {"title": "track 1"},"geometry": {"type": "MultiLineString","coordinates": [[[-122,45],[-122,46],[-121,46]],[[-121,45],[-121,46]]]}},{"type": "Feature", "properties": {"title": "track 2"},"geometry": {"type": "MultiLineString","coordinates": [[[-121,45.5],[-122,45.5]]]}}]}')
    result = JSON.parse(@@geoJSON.assemble_geojson(w))
    assert_equal(expected, result)
  end

end
