package voxgigfreesportssdk

import (
	"github.com/voxgig-sdk/free-sports-sdk/go/core"
	"github.com/voxgig-sdk/free-sports-sdk/go/entity"
	"github.com/voxgig-sdk/free-sports-sdk/go/feature"
	_ "github.com/voxgig-sdk/free-sports-sdk/go/utility"
)

// Type aliases preserve external API.
type FreeSportsSDK = core.FreeSportsSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type FreeSportsEntity = core.FreeSportsEntity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type FreeSportsError = core.FreeSportsError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewEventEntityFunc = func(client *core.FreeSportsSDK, entopts map[string]any) core.FreeSportsEntity {
		return entity.NewEventEntity(client, entopts)
	}
	core.NewLeagueEntityFunc = func(client *core.FreeSportsSDK, entopts map[string]any) core.FreeSportsEntity {
		return entity.NewLeagueEntity(client, entopts)
	}
	core.NewPlayerEntityFunc = func(client *core.FreeSportsSDK, entopts map[string]any) core.FreeSportsEntity {
		return entity.NewPlayerEntity(client, entopts)
	}
	core.NewTeamEntityFunc = func(client *core.FreeSportsSDK, entopts map[string]any) core.FreeSportsEntity {
		return entity.NewTeamEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewFreeSportsSDK = core.NewFreeSportsSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig

// No-arg convenience constructors. Go has no default-argument syntax,
// so these aliases let callers write `sdk.New()` / `sdk.Test()`
// instead of `sdk.NewFreeSportsSDK(nil)` / `sdk.TestSDK(nil, nil)`
// for the common no-options case.
func New() *FreeSportsSDK  { return NewFreeSportsSDK(nil) }
func Test() *FreeSportsSDK { return TestSDK(nil, nil) }
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
