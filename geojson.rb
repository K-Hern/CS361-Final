#!/usr/bin/env ruby

require 'json'

class GEOJSON
  private

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

    if (feature.get_name())
      properties["title"] = feature.get_name()
    end

    begin
      icon = feature.get_icon_type()

      if (icon)
        properties["icon"] = icon
      end
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

  public

  def assemble_feature_geojson(featureObj, return_hash: false)
    featureHash = self.create_feature_hash()
      self.fill_feature_hash(featureHash, featureObj)

    return (return_hash) ? featureHash : JSON.generate(featureHash)
  end

  def assemble_geojson(featureSetObj)
    featureSet = featureSetObj.get_features()
    hash = self.create_top_hash()

    featureSet.each do |featureObj|
      featureHash = self.assemble_feature_geojson(featureObj, return_hash: true)

      hash["features"].append(featureHash)
    end

    return JSON.generate(hash)
  end
end
