#include "geoip_ruby.h"


VALUE cGeoIP;
VALUE cGeoIPRecord;
VALUE cGeoIPError;
VALUE cGeoIPRecordNotFoundError;


//
// Net::GeoIP
//

VALUE
geoip_alloc(VALUE klass) {
	GeoIPContainer *container;

	container = ALLOC(GeoIPContainer);

	return Data_Wrap_Struct(klass, 0, geoip_free, container);
}

void
geoip_free(GeoIPContainer *container) {
	if (container->geoip) {
	  GeoIP_delete(container->geoip);
  }

	free(container);

	return;
}

/* call-seq:
 *   Net::GeoIP.new(database)
 *
 * Initializes a new GeoIP object.  The argument database is the path to the
 * database to open and use with this GeoIP instance.
 */
VALUE
geoip_initialize(VALUE self, VALUE database) {
	GeoIPContainer *container;

	Check_Type(database, T_STRING);

	Data_Get_Struct(self, GeoIPContainer, container);

	container->geoip = GeoIP_open(RSTRING(database)->ptr, GEOIP_INDEX_CACHE);

	if (container->geoip == NULL) {
		rb_raise(cGeoIPError,  "Invalid Database");
	}

	return self;
}

/* call-seq:
 *   geoip[ip_address]
 *
 * Return a Net::GeoIP::Record object corresponding to the IP address specified.
 */
VALUE
geoip_index(VALUE self, VALUE index) {
	VALUE record;
	VALUE argv[2];

	Check_Type(index, T_STRING);

	argv[0] = self;
	argv[1] = index;

	record = rb_class_new_instance(2, argv, cGeoIPRecord);
	rb_gc_register_address(&record);

	return record;
}


//
// Extension initialization.
//

void
Init_geoip() {
	VALUE mNet;

	mNet = rb_define_module("Net");

	cGeoIP = rb_define_class_under(mNet, "GeoIP", rb_cObject);
	rb_define_alloc_func(cGeoIP, geoip_alloc);
	rb_define_method(cGeoIP, "initialize", geoip_initialize, 1);
	rb_define_method(cGeoIP, "[]", geoip_index, 1);

	cGeoIPRecord = rb_define_class_under(cGeoIP, "Record", rb_cObject);
	rb_define_alloc_func(cGeoIPRecord, geoip_record_alloc);
	rb_define_method(cGeoIPRecord, "initialize", geoip_record_initialize, 2);
	rb_define_method(cGeoIPRecord, "country_code", geoip_record_country_code, 0);
	rb_define_method(cGeoIPRecord, "country_code3", geoip_record_country_code3, 0);
	rb_define_method(cGeoIPRecord, "country_name", geoip_record_country_name, 0);
	rb_define_method(cGeoIPRecord, "region", geoip_record_region, 0);
	rb_define_method(cGeoIPRecord, "city", geoip_record_city, 0);
	rb_define_method(cGeoIPRecord, "postal_code", geoip_record_postal_code, 0);
	rb_define_method(cGeoIPRecord, "latitude", geoip_record_latitude, 0);
	rb_define_method(cGeoIPRecord, "longitude", geoip_record_longitude, 0);
	rb_define_method(cGeoIPRecord, "dma_code", geoip_record_dma_code, 0);
	rb_define_method(cGeoIPRecord, "area_code", geoip_record_area_code, 0);

	cGeoIPError = rb_define_class_under(mNet, "GeoIPError", rb_eException);
	cGeoIPRecordNotFoundError = rb_define_class_under(cGeoIP, "RecordNotFoundError", rb_eException);

	return;
}
