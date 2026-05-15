# FreeSports SDK utility: feature_add
module FreeSportsUtilities
  FeatureAdd = ->(ctx, f) {
    ctx.client.features << f
  }
end
