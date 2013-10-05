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
      @end.nil? ? self : Chain.new(@end.public_send(*args, &block))
    end
  end
end

class Object
  def mayhaps
    self
  end

  def mayhaps_chain
    Mayhaps::Chain.new(self)
  end
end

class NilClass
  def mayhaps
    Mayhaps::Nothing.instance
  end
end
