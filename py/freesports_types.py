# Typed models for the FreeSports SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.
#
# These are TypedDicts, not dataclasses: the SDK ops return/accept plain dicts
# at runtime, and a TypedDict IS a dict shape, so the types match the runtime.
# Optional (req:false) keys are modelled as TypedDict key-optionality
# (total=False), split into a required base + total=False subclass when a type
# has both required and optional keys.

from __future__ import annotations

from typing import TypedDict, Any


class Event(TypedDict, total=False):
    date_event: str
    id_event: str
    int_away_score: str
    int_home_score: str
    str_away_team: str
    str_event: str
    str_home_team: str
    str_league: str
    str_sport: str
    str_status: str
    str_thumb: str
    str_time: str
    str_venue: str
    str_video: str


class EventListMatch(TypedDict):
    api_key: str


class League(TypedDict, total=False):
    id_league: str
    int_formed_year: str
    str_badge: str
    str_country: str
    str_description_en: str
    str_league: str
    str_league_alternate: str
    str_logo: str
    str_sport: str
    str_website: str


class LeagueListMatch(TypedDict):
    api_key: str


class Player(TypedDict, total=False):
    date_born: str
    id_player: str
    str_cutout: str
    str_description_en: str
    str_height: str
    str_nationality: str
    str_player: str
    str_position: str
    str_sport: str
    str_team: str
    str_thumb: str
    str_weight: str


class PlayerListMatch(TypedDict):
    api_key: str


class Team(TypedDict, total=False):
    id_team: str
    int_formed_year: str
    int_stadium_capacity: str
    str_alternate: str
    str_description_en: str
    str_league: str
    str_sport: str
    str_stadium: str
    str_stadium_location: str
    str_team: str
    str_team_badge: str
    str_team_jersey: str
    str_website: str


class TeamListMatch(TypedDict):
    api_key: str
