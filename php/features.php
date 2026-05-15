<?php
declare(strict_types=1);

// FreeSports SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class FreeSportsFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new FreeSportsBaseFeature();
            case "test":
                return new FreeSportsTestFeature();
            default:
                return new FreeSportsBaseFeature();
        }
    }
}
