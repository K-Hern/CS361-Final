#!/usr/bin/env ruby

require 'json'

class Track
  attr_accessor :name, :trackSegmentObjsList

  def initialize(trackSegmentObjsList, name=nil)
    @name = name
    @trackSegmentObjsList = trackSegmentObjsList
  end

  public

  def add_segment(newTrackObj)
    self.trackSegmentObjs << newTrackObj
  end

  def remove_segment(trackObj)
    self.trackSegmentObjs.remove(trackObj)
  end

  def edit_name(newName)
    self.name = newName
  end

  def get_name()
    return self.name
  end

  def get_track_segments()
    return self.trackSegmentObjsList
  end

  def get_coordinates()
    coordinatesList = []
    segmentsObjList = self.get_track_segments

    segmentsObjList.each do |trackSegmentObj|
      coordinatesList.append(trackSegmentObj.get_coordinates())
    end

    return coordinatesList
  end

end


class TrackSegment
  attr_reader :wayPointList

  def initialize(wayPointObjsList)
    @wayPointList = wayPointObjsList
  end

  public

  def add_waypoint(pointObj)
    self.wayPointList.append(wayPointObj)
  end

  def remove_waypoint(wayPointObj)
    self.wayPointList.remove(wayPointObj)
  end

  def get_coordinates()
    coordinateList = []

    self.wayPointList.each do |wayPoint|
      coordinateList.append << wayPoint.get_coordinates()
    end

    return coordinateList
  end

end

class Waypoint
  attr_reader :latitude, :longitude, :elevation, :name, :iconType

  def initialize(longitude, latitude, elevation=nil, name=nil, iconType=nil)
    @latitude = latitude
    @longitude = longitude
    @elevation = elevation
    @name = name
    @iconType = iconType
  end

  public

  def get_coordinates()
    coordinateList = [self.longitude, self.latitude]
    if self.elevation
      coordinateList.append(self.elevation)
    end

    return coordinateList
  end

  def get_name()
    return self.name ? self.name : nil
  end

  def get_icon_type()
    return self.iconType
  end
end

class FeatureSet
  attr_accessor :featureSetName, :featureSet

  def initialize(featureSetName, featureSet)
    @featureSetName = featureSetName
    @featureSet = featureSet
  end

  public

  def get_feature_set()
    return self.featureSet
  end

  def get_name()
    return self.featureSetName
  end

end

class GEOJSON

  def create_top_hash()
    hash = {
      "type" => "FeatureCollection",
      "features" => []
    }

    return hash
  end

  def create_feature_hash()
    hash = {
      "type" => "Feature",
      "properties" => {},
      "geometry" => {
        "type" => nil,
        "coordinates" => []
      }
    }

    return hash
  end

  def fill_properties(hash, feature)
    properties = hash["properties"]

    properties["title"] = feature.get_name()

    begin
      properties["icon"] = feature.get_icon_type()
    rescue NoMethodError
      # Feature has no icon
    end
  end

  def fill_geometry(hash, feature)
    geometry = hash["geometry"]

    geometry["coordinates"] += feature.get_coordinates()
    geometry["type"] = ((geometry["coordinates"][0]).is_a?(Array)) ? "MultiLineString" : "Point"

  end

  def fill_feature_hash(hash, feature)
    self.fill_properties(hash, feature)
    self.fill_geometry(hash, feature)
  end

  def assemble_geojson(featureSet)
    hash = self.create_top_hash()

    featureSet.each do |feature|
      featureHash = self.create_feature_hash()
      self.fill_feature_hash(featureHash, feature)
      hash["features"].append(featureHash)
    end

    return JSON.generate(hash)
  end
end

def main()
  homeWaypoint = Waypoint.new(longitude = -121.5, latitude = 45.5, elevation = 30, name = "home", iconType = "flag")
  storeWaypoint = Waypoint.new(longitude = -121.5, latitude = 45.6, elevation = nil, name = "store", iconType = "dot")

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

  myData_Set = FeatureSet.new("My Data", [homeWaypoint, storeWaypoint, track1, track2])
  geoJSON = GEOJSON.new()

  puts geoJSON.assemble_geojson(myData_Set.get_feature_set())
end

if File.identical?(__FILE__, $0)
  main()
end
