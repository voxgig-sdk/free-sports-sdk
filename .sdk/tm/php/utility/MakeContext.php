<?php
declare(strict_types=1);

// FreeSports SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class FreeSportsMakeContext
{
    public static function call(array $ctxmap, ?FreeSportsContext $basectx): FreeSportsContext
    {
        return new FreeSportsContext($ctxmap, $basectx);
    }
}
