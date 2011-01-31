require 'test/unit'
require 'geoip_test_helpers'

require 'max_mind/net/geoip'


class GeoIPIndexTest < Test::Unit::TestCase
  include GeoIPTestHelpers

  def setup
    @geoip = MaxMind::Net::GeoIP.new(city_database_filename)
  end

  def test_should_bitch_when_indexed_with_non_string
    assert_raises(TypeError) { @geoip[0] }
  end

  def test_should_get_geoip_record_when_indexing_geoip_with_string
    assert_kind_of MaxMind::Net::GeoIP::Record, @geoip['bravenet.com']
  end

end
