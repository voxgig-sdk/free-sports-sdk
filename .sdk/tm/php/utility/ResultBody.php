<?php
declare(strict_types=1);

// FreeSports SDK utility: result_body

class FreeSportsResultBody
{
    public static function call(FreeSportsContext $ctx): ?FreeSportsResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
