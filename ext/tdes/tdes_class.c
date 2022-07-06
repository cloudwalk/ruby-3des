#include <assert.h>
#include <openssl/des.h>
#include "tdes_class.h"

// Key structure containing pre-processed TDES key schedules.
struct Key {
	DES_key_schedule ks1, ks2, ks3;
};

// Instantiate a TDES object.
// This will embed the key schedules as C data in the object.
VALUE tdes_new(VALUE class, VALUE key) {
	char* raw_key = StringValuePtr(key);
	long key_length = RSTRING_LEN(key);

	struct Key* key_data = NULL;
	VALUE self = Data_Make_Struct(class, struct Key, NULL, free, key_data);
	if (key_data == NULL) {
		rb_raise(rb_eRuntimeError, "Failed to setup internal data");
	}

	int err;
	switch (key_length) {
	case 24:
		err = DES_set_key_checked((void*) raw_key + 16, &key_data->ks3);
		if (err) {
			rb_raise(rb_eArgError, "Invalid DES key");
		}
	case 16:
		err = DES_set_key_checked((void*) raw_key + 8, &key_data->ks2);
		if (err) {
			rb_raise(rb_eArgError, "Invalid DES key");
		}
		err = DES_set_key_checked((void*) raw_key + 0, &key_data->ks1);
		if (err) {
			rb_raise(rb_eArgError, "Invalid DES key");
		}
		break;

	default:
		rb_raise(rb_eArgError, "Invalid DES key length (%ld)", key_length);
	}

	rb_obj_call_init(self, 0, NULL);

	return self;
}

// Encrypt/decrypt data using TDES EDE using ECB.
// Data length must be a multiple of 8.
static VALUE tdes_encryption(VALUE self, VALUE data, int operation) {
	char* raw_data = StringValuePtr(data);
	long data_length = RSTRING_LEN(data);

	if (data_length % 8 != 0) {
		rb_raise(rb_eArgError, "Invalid DES data length");
	}

	struct Key* key;
	Data_Get_Struct(self, struct Key, key);

	VALUE encrypted = rb_str_buf_new(data_length);

	assert(data_length % 8 == 0);
	for (size_t i = 0; i < data_length; i += 8) {
		DES_cblock out;
		DES_ecb3_encrypt(
			(void*) raw_data + i,
			&out,
			&key->ks1,
			&key->ks2,
			&key->ks3,
			operation
		);
		rb_str_buf_cat(encrypted, (char *) out, 8);
	}

	return encrypted;
}

static VALUE tdes_encrypt(VALUE self, VALUE data) {
	return tdes_encryption(self, data, DES_ENCRYPT);
}

static VALUE tdes_decrypt(VALUE self, VALUE data) {
	return tdes_encryption(self, data, DES_DECRYPT);
}

void setup_tdes_class(VALUE module) {
	VALUE tdes_class = rb_define_class_under(module, "TDES", rb_cObject);
	rb_define_singleton_method(tdes_class, "new", tdes_new, 1);
	rb_define_method(tdes_class, "encrypt", tdes_encrypt, 1);
	rb_define_method(tdes_class, "decrypt", tdes_decrypt, 1);
}
