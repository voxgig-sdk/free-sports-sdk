<?php
declare(strict_types=1);

// FreeSports SDK utility: feature_add

class FreeSportsFeatureAdd
{
    public static function call(FreeSportsContext $ctx, mixed $f): void
    {
        $ctx->client->features[] = $f;
    }
}
