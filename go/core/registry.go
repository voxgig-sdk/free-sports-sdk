package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewEventEntityFunc func(client *FreeSportsSDK, entopts map[string]any) FreeSportsEntity

var NewLeagueEntityFunc func(client *FreeSportsSDK, entopts map[string]any) FreeSportsEntity

var NewPlayerEntityFunc func(client *FreeSportsSDK, entopts map[string]any) FreeSportsEntity

var NewTeamEntityFunc func(client *FreeSportsSDK, entopts map[string]any) FreeSportsEntity

