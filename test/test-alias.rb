require 'test/unit'
$VERBOSE = true

class ::DummyClass
  def self.dummy_method
    :ok
  end
end

require_relative '../lib/mug/alias'
class Test_alias < Test::Unit::TestCase

  def test_alias
    assert_equal( :ok, ::DummyClass.dummy_method )
    assert_raise(NoMethodError) { ::DummyClass.aliased_method }

    ::DummyClass.instance_eval do
      alias_singleton_method :aliased_method, :dummy_method
    end
    assert_equal( :ok, ::DummyClass.dummy_method )
    assert_equal( :ok, ::DummyClass.aliased_method )
  end

  def test_alias_return
    result = ::DummyClass.instance_eval do
      alias_singleton_method :aliased_method2, :dummy_method
    end
    assert_equal( ::DummyClass, result )
  end

  def test_alias_private
    assert_raise(NoMethodError) { ::DummyClass.alias_singleton_method :aliased_method3, :dummy_method }
  end

end

