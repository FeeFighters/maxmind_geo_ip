# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{maxmind_geo_ip}
  s.version = "0.7.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["MaxMind"]
  s.date = %q{2009-02-25}
  s.description = %q{MaxMind Ruby GeoIP API, for accessing MaxMind GeoIP data files}
  s.email = %q{josh@feefighters.com}
  s.files = ['lib/max_mind/net/geoip.bundle'].flatten
  s.executables = []
  s.has_rdoc = false
  s.homepage = %q{https://github.com/FeeFighters/maxmind_geo_ip}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Use this gem to access MaxMind GeoIP data files.  C library is built-in, so no dependencies are needed.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end