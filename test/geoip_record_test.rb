require 'test/unit'
require 'geoip_test_helpers'

require 'max_mind/net/geoip'


class GeoIPRecordTest < Test::Unit::TestCase
  include GeoIPTestHelpers

  def setup
    @database = MaxMind::Net::GeoIP.new(city_database_filename)
  end

  def test_should_have_geoip_record_defined
    assert_not_nil MaxMind::Net::GeoIP::Record
  end

  def test_should_create_geoip_record_with_database_and_string
    assert_kind_of MaxMind::Net::GeoIP::Record, MaxMind::Net::GeoIP::Record.new(@database, 'bravenet.com')
  end

  def test_should_bitch_if_first_constructor_arg_is_not_database
    assert_raises(TypeError) { MaxMind::Net::GeoIP::Record.new('', '') }
  end

  def test_should_bitch_if_second_constructor_arg_is_not_string
    assert_raises(TypeError) { MaxMind::Net::GeoIP::Record.new(@database, 0) }
  end

  def test_should_bitch_if_both_constructor_args_are_incorrect
    assert_raises(TypeError) { MaxMind::Net::GeoIP::Record.new('', 0) }
  end

end
