require 'mayhaps'

class Object
  alias_method :maybe, :mayhaps
  alias_method :maybe_chain, :mayhaps_chain
end
