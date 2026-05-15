<?php
declare(strict_types=1);

// FreeSports SDK utility: prepare_body

class FreeSportsPrepareBody
{
    public static function call(FreeSportsContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
