require File.expand_path 'test_helper', File.dirname(__FILE__)

class TestFind < MiniTest::Test

  def test_find
    res = IRKit.find
    assert_equal res.class, Array
    assert res.first =~ /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/,
           "#{res.first} is not IP Address"
  end

end
