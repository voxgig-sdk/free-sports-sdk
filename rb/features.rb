# FreeSports SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module FreeSportsFeatures
  def self.make_feature(name)
    case name
    when "base"
      FreeSportsBaseFeature.new
    when "test"
      FreeSportsTestFeature.new
    else
      FreeSportsBaseFeature.new
    end
  end
end
