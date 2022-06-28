# TDES

Ruby native extension for triple DES cryptography.

## Install

```bash
sudo gem install tdes
```

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
