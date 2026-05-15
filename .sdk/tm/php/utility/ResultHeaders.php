<?php
declare(strict_types=1);

// FreeSports SDK utility: result_headers

class FreeSportsResultHeaders
{
    public static function call(FreeSportsContext $ctx): ?FreeSportsResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
