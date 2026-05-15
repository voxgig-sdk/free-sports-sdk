# FreeSports SDK exists test

require "minitest/autorun"
require_relative "../FreeSports_sdk"

class ExistsTest < Minitest::Test
  def test_create_test_sdk
    testsdk = FreeSportsSDK.test(nil, nil)
    assert !testsdk.nil?
  end
end
