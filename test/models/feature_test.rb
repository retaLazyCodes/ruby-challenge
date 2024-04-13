require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  test "should save a valid feature" do
    feature = Feature.new(
    external_id: '123',
    magnitude: 5.0,
    place: 'Test place',
    time: Time.now,
    url: 'http://example.com',
    tsunami: false,
    mag_type: 'Test',
    title: 'Test feature',
    coordinates: { longitude: 10.0, latitude: 20.0 }
  )

  assert feature.valid?, "Feature is not valid"
  assert feature.save, "Feature was not saved"
  end

  test "coordinates should be present" do
    feature = Feature.new(
      external_id: '123',
      magnitude: 5.0,
      place: 'Test place',
      time: Time.now,
      url: 'http://example.com',
      tsunami: false,
      mag_type: 'Test',
      title: 'Test feature'
    )

    assert_not feature.valid?, "Feature without coordinates is valid"
    assert_not feature.save, "Saved the feature without coordinates"
  end

  test "coordinates must respect a range of values" do
    feature = Feature.new(
      external_id: '123',
      magnitude: 5.0,
      place: 'Test place',
      time: Time.now,
      url: 'http://example.com',
      tsunami: false,
      mag_type: 'Test',
      title: 'Test feature',
      coordinates: { longitude: 200.0, latitude: -100.0 }
    )

    assert_not feature.valid?, "Feature has invalid coordinates range"
  end
end
