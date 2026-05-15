# FreeSports SDK feature factory

from feature.base_feature import FreeSportsBaseFeature
from feature.test_feature import FreeSportsTestFeature


def _make_feature(name):
    features = {
        "base": lambda: FreeSportsBaseFeature(),
        "test": lambda: FreeSportsTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
