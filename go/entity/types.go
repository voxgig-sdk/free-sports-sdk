// Typed models for the FreeSports SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import "encoding/json"

// Event is the typed data model for the event entity.
type Event struct {
	DateEvent *string `json:"date_event,omitempty"`
	IdEvent *string `json:"id_event,omitempty"`
	IntAwayScore *string `json:"int_away_score,omitempty"`
	IntHomeScore *string `json:"int_home_score,omitempty"`
	StrAwayTeam *string `json:"str_away_team,omitempty"`
	StrEvent *string `json:"str_event,omitempty"`
	StrHomeTeam *string `json:"str_home_team,omitempty"`
	StrLeague *string `json:"str_league,omitempty"`
	StrSport *string `json:"str_sport,omitempty"`
	StrStatus *string `json:"str_status,omitempty"`
	StrThumb *string `json:"str_thumb,omitempty"`
	StrTime *string `json:"str_time,omitempty"`
	StrVenue *string `json:"str_venue,omitempty"`
	StrVideo *string `json:"str_video,omitempty"`
}

// EventListMatch is the typed request payload for Event.ListTyped.
type EventListMatch struct {
	ApiKey string `json:"api_key"`
}

// League is the typed data model for the league entity.
type League struct {
	IdLeague *string `json:"id_league,omitempty"`
	IntFormedYear *string `json:"int_formed_year,omitempty"`
	StrBadge *string `json:"str_badge,omitempty"`
	StrCountry *string `json:"str_country,omitempty"`
	StrDescriptionEn *string `json:"str_description_en,omitempty"`
	StrLeague *string `json:"str_league,omitempty"`
	StrLeagueAlternate *string `json:"str_league_alternate,omitempty"`
	StrLogo *string `json:"str_logo,omitempty"`
	StrSport *string `json:"str_sport,omitempty"`
	StrWebsite *string `json:"str_website,omitempty"`
}

// LeagueListMatch is the typed request payload for League.ListTyped.
type LeagueListMatch struct {
	ApiKey string `json:"api_key"`
}

// Player is the typed data model for the player entity.
type Player struct {
	DateBorn *string `json:"date_born,omitempty"`
	IdPlayer *string `json:"id_player,omitempty"`
	StrCutout *string `json:"str_cutout,omitempty"`
	StrDescriptionEn *string `json:"str_description_en,omitempty"`
	StrHeight *string `json:"str_height,omitempty"`
	StrNationality *string `json:"str_nationality,omitempty"`
	StrPlayer *string `json:"str_player,omitempty"`
	StrPosition *string `json:"str_position,omitempty"`
	StrSport *string `json:"str_sport,omitempty"`
	StrTeam *string `json:"str_team,omitempty"`
	StrThumb *string `json:"str_thumb,omitempty"`
	StrWeight *string `json:"str_weight,omitempty"`
}

// PlayerListMatch is the typed request payload for Player.ListTyped.
type PlayerListMatch struct {
	ApiKey string `json:"api_key"`
}

// Team is the typed data model for the team entity.
type Team struct {
	IdTeam *string `json:"id_team,omitempty"`
	IntFormedYear *string `json:"int_formed_year,omitempty"`
	IntStadiumCapacity *string `json:"int_stadium_capacity,omitempty"`
	StrAlternate *string `json:"str_alternate,omitempty"`
	StrDescriptionEn *string `json:"str_description_en,omitempty"`
	StrLeague *string `json:"str_league,omitempty"`
	StrSport *string `json:"str_sport,omitempty"`
	StrStadium *string `json:"str_stadium,omitempty"`
	StrStadiumLocation *string `json:"str_stadium_location,omitempty"`
	StrTeam *string `json:"str_team,omitempty"`
	StrTeamBadge *string `json:"str_team_badge,omitempty"`
	StrTeamJersey *string `json:"str_team_jersey,omitempty"`
	StrWebsite *string `json:"str_website,omitempty"`
}

// TeamListMatch is the typed request payload for Team.ListTyped.
type TeamListMatch struct {
	ApiKey string `json:"api_key"`
}

// asMap turns a typed request/data struct into the map[string]any the
// runtime op pipeline consumes, honouring the json tags above.
func asMap(v any) map[string]any {
	out := map[string]any{}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedFrom decodes a runtime value (a map[string]any produced by the op
// pipeline) into a typed model T via a JSON round-trip. On any error it
// returns the zero value of T; the op's own (value, error) tuple carries the
// real error.
func typedFrom[T any](v any) T {
	var out T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedSliceFrom decodes a runtime list value ([]any of maps) into a typed
// slice []T via a JSON round-trip, for list ops.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
