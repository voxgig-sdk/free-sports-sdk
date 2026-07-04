# frozen_string_literal: true

# Typed models for the FreeSports SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# Event entity data model.
#
# @!attribute [rw] date_event
#   @return [String, nil]
#
# @!attribute [rw] id_event
#   @return [String, nil]
#
# @!attribute [rw] int_away_score
#   @return [String, nil]
#
# @!attribute [rw] int_home_score
#   @return [String, nil]
#
# @!attribute [rw] str_away_team
#   @return [String, nil]
#
# @!attribute [rw] str_event
#   @return [String, nil]
#
# @!attribute [rw] str_home_team
#   @return [String, nil]
#
# @!attribute [rw] str_league
#   @return [String, nil]
#
# @!attribute [rw] str_sport
#   @return [String, nil]
#
# @!attribute [rw] str_status
#   @return [String, nil]
#
# @!attribute [rw] str_thumb
#   @return [String, nil]
#
# @!attribute [rw] str_time
#   @return [String, nil]
#
# @!attribute [rw] str_venue
#   @return [String, nil]
#
# @!attribute [rw] str_video
#   @return [String, nil]
Event = Struct.new(
  :date_event,
  :id_event,
  :int_away_score,
  :int_home_score,
  :str_away_team,
  :str_event,
  :str_home_team,
  :str_league,
  :str_sport,
  :str_status,
  :str_thumb,
  :str_time,
  :str_venue,
  :str_video,
  keyword_init: true
)

# Request payload for Event#list.
#
# @!attribute [rw] api_key
#   @return [String]
EventListMatch = Struct.new(
  :api_key,
  keyword_init: true
)

# League entity data model.
#
# @!attribute [rw] id_league
#   @return [String, nil]
#
# @!attribute [rw] int_formed_year
#   @return [String, nil]
#
# @!attribute [rw] str_badge
#   @return [String, nil]
#
# @!attribute [rw] str_country
#   @return [String, nil]
#
# @!attribute [rw] str_description_en
#   @return [String, nil]
#
# @!attribute [rw] str_league
#   @return [String, nil]
#
# @!attribute [rw] str_league_alternate
#   @return [String, nil]
#
# @!attribute [rw] str_logo
#   @return [String, nil]
#
# @!attribute [rw] str_sport
#   @return [String, nil]
#
# @!attribute [rw] str_website
#   @return [String, nil]
League = Struct.new(
  :id_league,
  :int_formed_year,
  :str_badge,
  :str_country,
  :str_description_en,
  :str_league,
  :str_league_alternate,
  :str_logo,
  :str_sport,
  :str_website,
  keyword_init: true
)

# Request payload for League#list.
#
# @!attribute [rw] api_key
#   @return [String]
LeagueListMatch = Struct.new(
  :api_key,
  keyword_init: true
)

# Player entity data model.
#
# @!attribute [rw] date_born
#   @return [String, nil]
#
# @!attribute [rw] id_player
#   @return [String, nil]
#
# @!attribute [rw] str_cutout
#   @return [String, nil]
#
# @!attribute [rw] str_description_en
#   @return [String, nil]
#
# @!attribute [rw] str_height
#   @return [String, nil]
#
# @!attribute [rw] str_nationality
#   @return [String, nil]
#
# @!attribute [rw] str_player
#   @return [String, nil]
#
# @!attribute [rw] str_position
#   @return [String, nil]
#
# @!attribute [rw] str_sport
#   @return [String, nil]
#
# @!attribute [rw] str_team
#   @return [String, nil]
#
# @!attribute [rw] str_thumb
#   @return [String, nil]
#
# @!attribute [rw] str_weight
#   @return [String, nil]
Player = Struct.new(
  :date_born,
  :id_player,
  :str_cutout,
  :str_description_en,
  :str_height,
  :str_nationality,
  :str_player,
  :str_position,
  :str_sport,
  :str_team,
  :str_thumb,
  :str_weight,
  keyword_init: true
)

# Request payload for Player#list.
#
# @!attribute [rw] api_key
#   @return [String]
PlayerListMatch = Struct.new(
  :api_key,
  keyword_init: true
)

# Team entity data model.
#
# @!attribute [rw] id_team
#   @return [String, nil]
#
# @!attribute [rw] int_formed_year
#   @return [String, nil]
#
# @!attribute [rw] int_stadium_capacity
#   @return [String, nil]
#
# @!attribute [rw] str_alternate
#   @return [String, nil]
#
# @!attribute [rw] str_description_en
#   @return [String, nil]
#
# @!attribute [rw] str_league
#   @return [String, nil]
#
# @!attribute [rw] str_sport
#   @return [String, nil]
#
# @!attribute [rw] str_stadium
#   @return [String, nil]
#
# @!attribute [rw] str_stadium_location
#   @return [String, nil]
#
# @!attribute [rw] str_team
#   @return [String, nil]
#
# @!attribute [rw] str_team_badge
#   @return [String, nil]
#
# @!attribute [rw] str_team_jersey
#   @return [String, nil]
#
# @!attribute [rw] str_website
#   @return [String, nil]
Team = Struct.new(
  :id_team,
  :int_formed_year,
  :int_stadium_capacity,
  :str_alternate,
  :str_description_en,
  :str_league,
  :str_sport,
  :str_stadium,
  :str_stadium_location,
  :str_team,
  :str_team_badge,
  :str_team_jersey,
  :str_website,
  keyword_init: true
)

# Request payload for Team#list.
#
# @!attribute [rw] api_key
#   @return [String]
TeamListMatch = Struct.new(
  :api_key,
  keyword_init: true
)

