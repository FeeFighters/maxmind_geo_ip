require 'mkmf'

# dir_config('GeoIP')
# have_library('GeoIP', 'GeoIP_new')
with_cflags('-DGEOIPDATADIR=\"/usr/local/share/GeoIP\"') do
  create_makefile('max_mind/net/geoip')
end
