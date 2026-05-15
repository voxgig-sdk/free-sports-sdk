# ProjectName SDK exists test

import pytest
from freesports_sdk import FreeSportsSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = FreeSportsSDK.test(None, None)
        assert testsdk is not None
