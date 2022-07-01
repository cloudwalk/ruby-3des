# TDES

Ruby native extension for triple DES cryptography.

## Install

```bash
sudo gem install tdes
```

## Building

As a native extension, building this gem requires a C compiler toolchain.

### Linux

Having OpenSSL and Ruby installed, it should work out of the box.

```bash
rake clean compile
```

### MacOS

You may need to explicitly set your OpenSSL installation directory:

```bash
export cflags='-std=c99 -I ~/.rbenv/versions/2.7.6/openssl/include/'
export ldflags='-lcrypto -L ~/.rbenv/versions/2.7.6/openssl/lib/'
rake clean compile
```

### Windows

lol

## Examples

```ruby
require 'rubygems'
require 'tdes'

key = '1111111111111111'
cipher = TDES::TDES.new(key)
encrypted = cipher.encrypt('12345678') # "b\xDD\x8EJaN\x1A\xF9"
decrypted = cipher.decrypt(encrypted) # "12345678"
```

## Copyright

MIT Licence. Copyright (c) 2022-2022 Cloudwalk.
