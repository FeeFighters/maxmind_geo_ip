require 'max_mind/net/geoip'

class MaxMind::Net::GeoIP::Record
  def inspect
    s = super
    attrs = [
      :country_code,
      :country_code3,
      :country_name,
      :region,
      :city,
      :postal_code,
      :latitude,
      :longitude,
      :area_code,
      :dma_code,
    ]
    attrs = attrs.collect {|a| "#{a}: #{attribute_for_inspect(a)}" }.join(', ')
    s.sub(/>/, "#{attrs}>")
  end

  private

  def attribute_for_inspect(attr_name)
    value = send(attr_name)

    if value.is_a?(String) && value.length > 50
      "#{value[0..50]}...".inspect
    elsif value.is_a?(Date) || value.is_a?(Time)
      %("#{value.to_s(:db)}")
    else
      value.inspect
    end
  end
end