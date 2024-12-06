#!/usr/bin/env ruby

class Track
  attr_accessor :name, :trackSegmentObjsList

  def initialize(trackSegmentObjsList, name=nil)
    @name = name
    @trackSegmentObjsList = trackSegmentObjsList
  end

  public

  def add_segment(newTrackObj)
    self.trackSegmentObjsList << newTrackObj
  end

  def remove_segment(trackObj)
    self.trackSegmentObjsList.delete(trackObj)
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

  def initialize(waypointObjsList)
    @wayPointList = waypointObjsList
  end

  public

  def add_waypoint(waypointObj)
    self.wayPointList.append(waypointObj)
  end

  def remove_waypoint(waypointObj)
    self.wayPointList.delete(waypointObj)
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

  def initialize(longitude, latitude, elevation: nil, name: nil, iconType: nil)
    @latitude = latitude
    @longitude = longitude
    @elevation = elevation
    @name = name
    @iconType = iconType
  end

  public

  def get_coordinates()
    coordinateList = [self.longitude, self.latitude]
    if (self.elevation)
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

  def get_features()
    return self.featureSet
  end

  def get_name()
    return self.featureSetName
  end
end
