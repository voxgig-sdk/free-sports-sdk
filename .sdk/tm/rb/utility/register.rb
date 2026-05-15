# FreeSports SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

FreeSportsUtility.registrar = ->(u) {
  u.clean = FreeSportsUtilities::Clean
  u.done = FreeSportsUtilities::Done
  u.make_error = FreeSportsUtilities::MakeError
  u.feature_add = FreeSportsUtilities::FeatureAdd
  u.feature_hook = FreeSportsUtilities::FeatureHook
  u.feature_init = FreeSportsUtilities::FeatureInit
  u.fetcher = FreeSportsUtilities::Fetcher
  u.make_fetch_def = FreeSportsUtilities::MakeFetchDef
  u.make_context = FreeSportsUtilities::MakeContext
  u.make_options = FreeSportsUtilities::MakeOptions
  u.make_request = FreeSportsUtilities::MakeRequest
  u.make_response = FreeSportsUtilities::MakeResponse
  u.make_result = FreeSportsUtilities::MakeResult
  u.make_point = FreeSportsUtilities::MakePoint
  u.make_spec = FreeSportsUtilities::MakeSpec
  u.make_url = FreeSportsUtilities::MakeUrl
  u.param = FreeSportsUtilities::Param
  u.prepare_auth = FreeSportsUtilities::PrepareAuth
  u.prepare_body = FreeSportsUtilities::PrepareBody
  u.prepare_headers = FreeSportsUtilities::PrepareHeaders
  u.prepare_method = FreeSportsUtilities::PrepareMethod
  u.prepare_params = FreeSportsUtilities::PrepareParams
  u.prepare_path = FreeSportsUtilities::PreparePath
  u.prepare_query = FreeSportsUtilities::PrepareQuery
  u.result_basic = FreeSportsUtilities::ResultBasic
  u.result_body = FreeSportsUtilities::ResultBody
  u.result_headers = FreeSportsUtilities::ResultHeaders
  u.transform_request = FreeSportsUtilities::TransformRequest
  u.transform_response = FreeSportsUtilities::TransformResponse
}
