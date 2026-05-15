<?php
declare(strict_types=1);

// FreeSports SDK utility registration

require_once __DIR__ . '/../core/UtilityType.php';
require_once __DIR__ . '/Clean.php';
require_once __DIR__ . '/Done.php';
require_once __DIR__ . '/MakeError.php';
require_once __DIR__ . '/FeatureAdd.php';
require_once __DIR__ . '/FeatureHook.php';
require_once __DIR__ . '/FeatureInit.php';
require_once __DIR__ . '/Fetcher.php';
require_once __DIR__ . '/MakeFetchDef.php';
require_once __DIR__ . '/MakeContext.php';
require_once __DIR__ . '/MakeOptions.php';
require_once __DIR__ . '/MakeRequest.php';
require_once __DIR__ . '/MakeResponse.php';
require_once __DIR__ . '/MakeResult.php';
require_once __DIR__ . '/MakePoint.php';
require_once __DIR__ . '/MakeSpec.php';
require_once __DIR__ . '/MakeUrl.php';
require_once __DIR__ . '/Param.php';
require_once __DIR__ . '/PrepareAuth.php';
require_once __DIR__ . '/PrepareBody.php';
require_once __DIR__ . '/PrepareHeaders.php';
require_once __DIR__ . '/PrepareMethod.php';
require_once __DIR__ . '/PrepareParams.php';
require_once __DIR__ . '/PreparePath.php';
require_once __DIR__ . '/PrepareQuery.php';
require_once __DIR__ . '/ResultBasic.php';
require_once __DIR__ . '/ResultBody.php';
require_once __DIR__ . '/ResultHeaders.php';
require_once __DIR__ . '/TransformRequest.php';
require_once __DIR__ . '/TransformResponse.php';

FreeSportsUtility::setRegistrar(function (FreeSportsUtility $u): void {
    $u->clean = [FreeSportsClean::class, 'call'];
    $u->done = [FreeSportsDone::class, 'call'];
    $u->make_error = [FreeSportsMakeError::class, 'call'];
    $u->feature_add = [FreeSportsFeatureAdd::class, 'call'];
    $u->feature_hook = [FreeSportsFeatureHook::class, 'call'];
    $u->feature_init = [FreeSportsFeatureInit::class, 'call'];
    $u->fetcher = [FreeSportsFetcher::class, 'call'];
    $u->make_fetch_def = [FreeSportsMakeFetchDef::class, 'call'];
    $u->make_context = [FreeSportsMakeContext::class, 'call'];
    $u->make_options = [FreeSportsMakeOptions::class, 'call'];
    $u->make_request = [FreeSportsMakeRequest::class, 'call'];
    $u->make_response = [FreeSportsMakeResponse::class, 'call'];
    $u->make_result = [FreeSportsMakeResult::class, 'call'];
    $u->make_point = [FreeSportsMakePoint::class, 'call'];
    $u->make_spec = [FreeSportsMakeSpec::class, 'call'];
    $u->make_url = [FreeSportsMakeUrl::class, 'call'];
    $u->param = [FreeSportsParam::class, 'call'];
    $u->prepare_auth = [FreeSportsPrepareAuth::class, 'call'];
    $u->prepare_body = [FreeSportsPrepareBody::class, 'call'];
    $u->prepare_headers = [FreeSportsPrepareHeaders::class, 'call'];
    $u->prepare_method = [FreeSportsPrepareMethod::class, 'call'];
    $u->prepare_params = [FreeSportsPrepareParams::class, 'call'];
    $u->prepare_path = [FreeSportsPreparePath::class, 'call'];
    $u->prepare_query = [FreeSportsPrepareQuery::class, 'call'];
    $u->result_basic = [FreeSportsResultBasic::class, 'call'];
    $u->result_body = [FreeSportsResultBody::class, 'call'];
    $u->result_headers = [FreeSportsResultHeaders::class, 'call'];
    $u->transform_request = [FreeSportsTransformRequest::class, 'call'];
    $u->transform_response = [FreeSportsTransformResponse::class, 'call'];
});
