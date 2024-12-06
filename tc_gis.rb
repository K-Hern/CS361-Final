require_relative 'gis.rb'
require 'test/unit'

class TestGis < Test::Unit::TestCase

  # Test for absence of icon in json when no icon given
  # Test for absence of name in json when no name given

  class TestTrack < TestGis
    def test_creation_of_track
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

      assert_nothing_raised do
        testTrack1 = Track.new([trackSegment1, trackSegment2, trackSegment3])
      end
    end

    def test_add_segment
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

      newSegment = TrackSegment.new([
        Waypoint.new(-125, 46.1),
        Waypoint.new(-120, 42.2)
      ])

      testTrack1 = Track.new([trackSegment1, trackSegment2, trackSegment3])

      testTrack1.add_segment(newSegment)

      newLength = testTrack1.trackSegmentObjsList.length()

      assert_equal(4, newLength)
    end

    def test_remove_segment
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

      testTrack1 = Track.new([trackSegment1, trackSegment2, trackSegment3])

      testTrack1.remove_segment(trackSegment3)

      newLength = testTrack1.trackSegmentObjsList.length()

      assert_equal(2, newLength)
    end

    def test_edit_name
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

      testTrack1 = Track.new([trackSegment1, trackSegment2, trackSegment3])

      testTrack1.edit_name("My Segment")

      assert_equal("My Segment", testTrack1.name)
    end

    def test_get_name
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

      testTrack1 = Track.new("Name of Segment", [trackSegment1, trackSegment2, trackSegment3])

      name = testTrack1.get_name()

      assert_equal("Name of Segment", name)
    end

    def test_get_track_segments
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

      testTrack1 = Track.new("Name of Segment", [trackSegment1, trackSegment2, trackSegment3])

      segmentList = [trackSegment1, trackSegment2, trackSegment3]

      assert_equal(segmentList, testTrack1.get_track_segments())
    end

    def test_get_track_coordinates
      trackSegment1 = TrackSegment.new([
        Waypoint.new(-122, 45, 300),
        Waypoint.new(-122, 46)
      ])

      trackSegment2 = TrackSegment.new([
        Waypoint.new(-121, 45),
        Waypoint.new(-121, 46)
      ])

      testTrack1 = Track.new("Name of Segment", [trackSegment1, trackSegment2])

      coord_list = testTrack1.get_track_coordinates()

      expected = [[-122, 45, 300], [-122, 46], [121, 45], [121, 46]]

      assert_equal(expected, coord_list)
    end

  end

  class TestTrackSegment < TestGis
    def test_creation_of_segment
      segment = TrackSegment.new()
    end

    def
    end

    def
    end
  end

  class TestWaypoint < TestGis
    def test_creation_of_wapoint
      homePoint = Waypoint.new()
    end

    def
    end

    def
    end
  end

  class TestFeatureSet < TestGis
    def test_creation_of_featureset
      aspenWaypoint = Waypoint.new()
      nyWaypoint = Waypoint.new()
      coWaypoint = Waypoint.new()
      parisWaypoint = Waypoint.new()

      homeSet = FeatureSet.new("My Homes", [aspenWaypoint, nyWaypoint, coWaypoint, parisWaypoint])
    end

    def
    end

    def
    end
  end
end
