require 'singleton'

module Mayhaps
  class Nothing
    include Singleton

    def method_missing(*args)
      nil
    end
  end

  class Chain
    attr_reader :end

    def initialize(obj)
      @end = obj
    end

    def method_missing(*args, &block)
      @end ? Chain.new(@end.public_send(*args, &block)) : self
    end
  end
end

class Object
  def maybe
    self
  end

  def maybe_chain
    Mayhaps::Chain.new(self)
  end
end

class NilClass
  def maybe
    Mayhaps::Nothing.instance
  end
end
