# frozen_string_literal: true

require 'minitest/autorun'
require 'tdes'

class TdesTest < Minitest::Test
  def setup
    key = '1111111111111111'
    @cipher = TDES::TDES.new(key)
  end

  def test_encrypt
    number = '12345678'

    assert_equal "\x85\x8B\x17m\xA8\xB1%\x03".b, @cipher.encrypt(number)
  end

  def test_decrypt
    number = '12345678'

    encrypted = @cipher.encrypt(number)

    assert_equal '12345678', @cipher.decrypt(encrypted)
  end
end
