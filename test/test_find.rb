require File.expand_path 'test_helper', File.dirname(__FILE__)

class TestFind < MiniTest::Test

  def test_find
    devices = IRKit::Device.find
    assert_equal devices.class, Array
    devices.each do |device|
      assert_equal device.class, IRKit::Device
    end
  end

end
