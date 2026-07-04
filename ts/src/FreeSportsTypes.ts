// Typed models for the FreeSports SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Event {
  date_event?: string
  id_event?: string
  int_away_score?: string
  int_home_score?: string
  str_away_team?: string
  str_event?: string
  str_home_team?: string
  str_league?: string
  str_sport?: string
  str_status?: string
  str_thumb?: string
  str_time?: string
  str_venue?: string
  str_video?: string
}

export interface EventListMatch {
  api_key: string
}

export interface League {
  id_league?: string
  int_formed_year?: string
  str_badge?: string
  str_country?: string
  str_description_en?: string
  str_league?: string
  str_league_alternate?: string
  str_logo?: string
  str_sport?: string
  str_website?: string
}

export interface LeagueListMatch {
  api_key: string
}

export interface Player {
  date_born?: string
  id_player?: string
  str_cutout?: string
  str_description_en?: string
  str_height?: string
  str_nationality?: string
  str_player?: string
  str_position?: string
  str_sport?: string
  str_team?: string
  str_thumb?: string
  str_weight?: string
}

export interface PlayerListMatch {
  api_key: string
}

export interface Team {
  id_team?: string
  int_formed_year?: string
  int_stadium_capacity?: string
  str_alternate?: string
  str_description_en?: string
  str_league?: string
  str_sport?: string
  str_stadium?: string
  str_stadium_location?: string
  str_team?: string
  str_team_badge?: string
  str_team_jersey?: string
  str_website?: string
}

export interface TeamListMatch {
  api_key: string
}

