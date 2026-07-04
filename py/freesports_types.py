# Typed models for the FreeSports SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.

from __future__ import annotations

from dataclasses import dataclass
from typing import Optional, Any


@dataclass
class Event:
    date_event: Optional[str] = None
    id_event: Optional[str] = None
    int_away_score: Optional[str] = None
    int_home_score: Optional[str] = None
    str_away_team: Optional[str] = None
    str_event: Optional[str] = None
    str_home_team: Optional[str] = None
    str_league: Optional[str] = None
    str_sport: Optional[str] = None
    str_status: Optional[str] = None
    str_thumb: Optional[str] = None
    str_time: Optional[str] = None
    str_venue: Optional[str] = None
    str_video: Optional[str] = None


@dataclass
class EventListMatch:
    api_key: str


@dataclass
class League:
    id_league: Optional[str] = None
    int_formed_year: Optional[str] = None
    str_badge: Optional[str] = None
    str_country: Optional[str] = None
    str_description_en: Optional[str] = None
    str_league: Optional[str] = None
    str_league_alternate: Optional[str] = None
    str_logo: Optional[str] = None
    str_sport: Optional[str] = None
    str_website: Optional[str] = None


@dataclass
class LeagueListMatch:
    api_key: str


@dataclass
class Player:
    date_born: Optional[str] = None
    id_player: Optional[str] = None
    str_cutout: Optional[str] = None
    str_description_en: Optional[str] = None
    str_height: Optional[str] = None
    str_nationality: Optional[str] = None
    str_player: Optional[str] = None
    str_position: Optional[str] = None
    str_sport: Optional[str] = None
    str_team: Optional[str] = None
    str_thumb: Optional[str] = None
    str_weight: Optional[str] = None


@dataclass
class PlayerListMatch:
    api_key: str


@dataclass
class Team:
    id_team: Optional[str] = None
    int_formed_year: Optional[str] = None
    int_stadium_capacity: Optional[str] = None
    str_alternate: Optional[str] = None
    str_description_en: Optional[str] = None
    str_league: Optional[str] = None
    str_sport: Optional[str] = None
    str_stadium: Optional[str] = None
    str_stadium_location: Optional[str] = None
    str_team: Optional[str] = None
    str_team_badge: Optional[str] = None
    str_team_jersey: Optional[str] = None
    str_website: Optional[str] = None


@dataclass
class TeamListMatch:
    api_key: str

