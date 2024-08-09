# TDES

Ruby native extension for triple DES cryptography.

## List all available rake tasks
```bash
rake --tasks
```

## Compile
```bash
rake clobber clean compile
```

## Run tests
```bash
rake test
```

## Build local version
```bash
rake build
```

## Build and Install local version
```bash
rake install
```

## Install version from Rubygems
```bash
sudo gem install tdes
```

## Push to Rubygems
```bash
rake release
```

### Linux

Having OpenSSL and Ruby installed, it should work out of the box.

### MacOS

You may need to explicitly set your OpenSSL installation directory

rbenv:
```bash
export CFLAGS='-std=c99 -I ~/.rbenv/versions/3.0.2/openssl/include/'
export LDFLAGS='-lcrypto -L ~/.rbenv/versions/3.0.2/openssl/lib/'
rake clean compile
```

homebrew with asdf:
```bash
export CFLAGS="-std=c99 -I /opt/homebrew/opt/openssl@3.0/include/"
export LDFLAGS="-lcrypto -L /opt/homebrew/opt/openssl@3.0/lib/"
export CPPFLAGS="-I /opt/homebrew/opt/openssl@3.0/include"
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
