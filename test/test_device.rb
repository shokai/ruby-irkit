require File.expand_path 'test_helper', File.dirname(__FILE__)

class TestDevice < MiniTest::Test

  def setup
    @device = IRKit::Device.find.first
  end

  def test_get_messages
    res = @device.get_messages
    assert_equal res.class, IRKit::Response
    assert_equal res.format, "raw"
    assert_equal res.freq, 38
    assert_equal res.data.class, Array
  end

end
