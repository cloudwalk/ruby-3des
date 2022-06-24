#include "ruby.h"

#include "tdes_class.h"

void Init_tdes(){
    VALUE root_mod = rb_define_module("TDES");
		setup_tdes_class(root_mod);
}
