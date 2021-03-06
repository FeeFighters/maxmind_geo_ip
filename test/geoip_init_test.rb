require 'test/unit'
require 'geoip_test_helpers'

require 'max_mind/net/geoip'


class GeoIPInitTest < Test::Unit::TestCase
  include GeoIPTestHelpers

  def test_should_require_net_geoip
    assert_not_nil require('max_mind/net/geoip')
  end

  def test_should_define_net_geoip_class
    assert_equal true, MaxMind::Net.const_defined?(:GeoIP)
  end

  def test_should_create_object_with_database_specified
    assert_not_nil MaxMind::Net::GeoIP.new(city_database_filename)
  end

  def test_should_raise_exceptoin_if_database_filename_is_not_a_string
    assert_raises(TypeError) { MaxMind::Net::GeoIP.new(0) }
  end

  def test_should_raise_exception_if_invalid_database_specified
    assert_raises(MaxMind::Net::GeoIPError) { MaxMind::Net::GeoIP.new(File.dirname(__FILE__) + '/../Rakefile') }
  end

end
