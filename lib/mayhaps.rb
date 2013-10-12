require 'singleton'

class Object
  def maybe
    if nil?
      Nothing.instance
    else
      Just.new(self)
    end
  end
end

module Maybe
  def maybe
    ::Just.new(self)
  end
end

class Just < BasicObject
  include ::Maybe

  def initialize(obj)
    if ::Maybe === obj || !obj.nil?
      @value = obj
    else
      ::Kernel.raise ::ArgumentError, 'object is nil'
    end
  end

  def +@
    @value
  end

  def method_missing(*args, &block)
    @value.public_send(*args, &block).maybe
  end

  def inspect
    "#<Just #{@value.inspect}>"
  end
end

class Nothing < BasicObject
  include ::Maybe, ::Singleton

  def +@
    nil
  end

  def method_missing(*args)
    self
  end

  def inspect
    '#<Nothing>'
  end
end
