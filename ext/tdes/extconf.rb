# frozen_string_literal: true

require 'mkmf'

abort 'missing openssl' unless have_library('ssl')
abort 'missing openssl/des.h' unless have_header('openssl/des.h')
abort 'missing type DES_key_schedule' unless have_type('DES_key_schedule', 'openssl/des.h')
abort 'missing type DES_cblock' unless have_type('DES_cblock', 'openssl/des.h')
abort 'missing DES_set_key_checked' unless
  have_func('int DES_set_key_checked(const_DES_cblock*, DES_key_schedule*)', 'openssl/des.h')
abort 'missing DES_ecb3_encrypt' unless
  have_func(
    'void DES_ecb3_encrypt(const_DES_cblock*, DES_cblock*, DES_key_schedule*, DES_key_schedule*, DES_key_schedule*, int)',
    'openssl/des.h'
  )

cflags = '-std=c99'
ldflags = '-l:libcrypto.a'
with_cflags(cflags) do
  with_ldflags(ldflags) do
    create_makefile 'tdes/tdes'
  end
end
