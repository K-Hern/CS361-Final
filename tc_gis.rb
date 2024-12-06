require_relative 'gis.rb'
require 'test/unit'

class TestGis < Test::Unit::TestCase

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

      testTrack1 = Track.new([trackSegment1, trackSegment2, trackSegment3], "Name of Segment")

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

      testTrack1 = Track.new([trackSegment1, trackSegment2, trackSegment3], "Name of Segment")

      segmentList = [trackSegment1, trackSegment2, trackSegment3]

      assert_equal(segmentList, testTrack1.get_track_segments())
    end

    def test_get_coordinates
      trackSegment1 = TrackSegment.new([
        Waypoint.new(-122, 45, elevation: 300),
        Waypoint.new(-122, 46)
      ])

      trackSegment2 = TrackSegment.new([
        Waypoint.new(-121, 45),
        Waypoint.new(-121, 46)
      ])

      testTrack1 = Track.new([trackSegment1, trackSegment2], "Name of Segment")

      expected = [[[-122, 45, 300], [-122, 46]], [[-121, 45], [-121, 46]]]

      assert_equal(expected, testTrack1.get_coordinates())
    end

  end

  class TestTrackSegment < TestGis
    def test_creation_of_segment
      waypointList = [
        Waypoint.new(-122, 45),
        Waypoint.new(-122, 46),
        Waypoint.new(-121, 46)
      ]

      assert_nothing_raised do
        segment = TrackSegment.new(waypointList)
      end
    end

    def test_add_waypoint
      trackSegment1 = TrackSegment.new([
        Waypoint.new(-122, 45),
        Waypoint.new(-122, 46),
        Waypoint.new(-121, 46)
      ])

      newWaypoint = Waypoint.new(-119, 39)

      trackSegment1.add_waypoint(newWaypoint)

      assert_equal(4, trackSegment1.wayPointList.length())
    end

    def test_remove_waypoint
      myWaypoint = Waypoint.new(-121, 46)

      trackSegment1 = TrackSegment.new([
        Waypoint.new(-122, 45),
        Waypoint.new(-122, 46),
        myWaypoint
      ])

      trackSegment1.remove_waypoint(myWaypoint)

      assert_equal(2, trackSegment1.wayPointList.length())
    end

    def test_get_coordinates
      trackSegment1 = TrackSegment.new([
        Waypoint.new(-122, 45),
        Waypoint.new(-122, 46),
        Waypoint.new(-121, 46)
      ])

      expected = [[-122, 45],
                  [-122, 46],
                  [-121, 46]]

      assert_equal(expected, trackSegment1.get_coordinates)
    end
  end

  class TestWaypoint < TestGis
    def test_creation_of_wapoint
      assert_nothing_raised do
        homePoint = Waypoint.new(-122, 46)
      end
    end

    def test_get_coordinates
      homePoint = Waypoint.new(-122, 46, elevation: 2000)

      assert_equal([-122, 46, 2000], homePoint.get_coordinates)
    end

    def test_get_name
      homePoint = Waypoint.new(-122, 46, elevation: 2000, elevation: 300, name: "Home")

      assert_equal("Home", homePoint.get_name)
    end

    def test_get_icon_type
      homePoint = Waypoint.new(-122, 46, iconType: "dot")

      assert_equal("dot", homePoint.get_icon_type)
    end
  end

  class TestFeatureSet < TestGis
    def test_creation_of_featureset
      aspenWaypoint = Waypoint.new(122, 56)
      nyWaypoint = Waypoint.new(121, 68)
      coWaypoint = Waypoint.new(124, 30)
      parisWaypoint = Waypoint.new(122, 90)

      assert_nothing_raised do
        homeSet = FeatureSet.new("My Homes", [aspenWaypoint, nyWaypoint, coWaypoint, parisWaypoint])
      end
    end

    def test_get_features
      aspenWaypoint = Waypoint.new(122, 56)
      nyWaypoint = Waypoint.new(121, 68)
      coWaypoint = Waypoint.new(124, 30)
      parisWaypoint = Waypoint.new(122, 90)

      homeSet = FeatureSet.new("My Homes", [aspenWaypoint, nyWaypoint, coWaypoint, parisWaypoint])

      assert_equal([aspenWaypoint, nyWaypoint, coWaypoint, parisWaypoint], homeSet.get_features)
    end

    def test_get_name
      aspenWaypoint = Waypoint.new(122, 56)
      nyWaypoint = Waypoint.new(121, 68)
      coWaypoint = Waypoint.new(124, 30)
      parisWaypoint = Waypoint.new(122, 90)

      homeSet = FeatureSet.new("My Homes", [aspenWaypoint, nyWaypoint, coWaypoint, parisWaypoint])

      assert_equal("My Homes", homeSet.get_name)
    end
  end
end
