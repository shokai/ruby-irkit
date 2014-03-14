require File.expand_path 'test_helper', File.dirname(__FILE__)

class TestTokenKeyDeviceID < MiniTest::Test

  def test_token_key_deviceid
    device = IRKit::Device.find.first
    token = device.get_token
    assert_equal token.class, String
    assert token =~ /^[a-zA-Z\d]+$/, "token must be Hex String"

    info = device.get_key_and_deviceid(token)
    assert_equal info.class, IRKit::Response
    assert_equal info.clientkey.class, String
    assert info.clientkey =~  /^[a-zA-Z\d]+$/, "clientkey must be Hex String"
    assert_equal info.deviceid.class, String
    assert info.deviceid =~  /^[a-zA-Z\d]+$/, "deviceid must be Hex String"
  end

end
