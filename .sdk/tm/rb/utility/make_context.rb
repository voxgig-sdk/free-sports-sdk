# FreeSports SDK utility: make_context
require_relative '../core/context'
module FreeSportsUtilities
  MakeContext = ->(ctxmap, basectx) {
    FreeSportsContext.new(ctxmap, basectx)
  }
end
