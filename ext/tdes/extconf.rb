# frozen_string_literal: true

require 'mkmf'

cflags = ENV['CFLAGS'] || '-std=c99'
ldflags = ENV['LDFLAGS'] || '-l:libcrypto.a'
with_cflags(cflags) do
  with_ldflags(ldflags) do
    abort 'missing openssl' unless have_library('ssl')
    abort 'missing openssl/des.h' unless have_header('openssl/des.h')
    abort 'missing type DES_key_schedule' unless have_type('DES_key_schedule', 'openssl/des.h')
    abort 'missing type DES_cblock' unless have_type('DES_cblock', 'openssl/des.h')

    # On MacOS, have_func does not work well because the default compiler is clang instead of gcc
    unless RUBY_PLATFORM.downcase.include? 'darwin'
      abort 'missing DES_set_key_checked' unless have_func('int DES_set_key_checked', 'openssl/des.h')
      abort 'missing DES_ecb3_encrypt' unless have_func('DES_ecb3_encrypt', 'openssl/des.h')
      # Check for a symbol/function specific to OpenSSL 3.x
      abort 'OpenSSL 3.x required (missing EVP_Cipher function)' unless have_func('EVP_Cipher')
    end

    create_makefile 'tdes/tdes'
  end
end
