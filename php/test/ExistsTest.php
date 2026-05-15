<?php
declare(strict_types=1);

// FreeSports SDK exists test

require_once __DIR__ . '/../freesports_sdk.php';

use PHPUnit\Framework\TestCase;

class ExistsTest extends TestCase
{
    public function test_create_test_sdk(): void
    {
        $testsdk = FreeSportsSDK::test(null, null);
        $this->assertNotNull($testsdk);
    }
}
