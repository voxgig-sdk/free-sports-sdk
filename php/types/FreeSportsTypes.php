<?php
declare(strict_types=1);

// Typed models for the FreeSports SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** Event entity data model. */
class Event
{
    public ?string $date_event = null;
    public ?string $id_event = null;
    public ?string $int_away_score = null;
    public ?string $int_home_score = null;
    public ?string $str_away_team = null;
    public ?string $str_event = null;
    public ?string $str_home_team = null;
    public ?string $str_league = null;
    public ?string $str_sport = null;
    public ?string $str_status = null;
    public ?string $str_thumb = null;
    public ?string $str_time = null;
    public ?string $str_venue = null;
    public ?string $str_video = null;
}

/** Request payload for Event#list. */
class EventListMatch
{
    public string $api_key;
}

/** League entity data model. */
class League
{
    public ?string $id_league = null;
    public ?string $int_formed_year = null;
    public ?string $str_badge = null;
    public ?string $str_country = null;
    public ?string $str_description_en = null;
    public ?string $str_league = null;
    public ?string $str_league_alternate = null;
    public ?string $str_logo = null;
    public ?string $str_sport = null;
    public ?string $str_website = null;
}

/** Request payload for League#list. */
class LeagueListMatch
{
    public string $api_key;
}

/** Player entity data model. */
class Player
{
    public ?string $date_born = null;
    public ?string $id_player = null;
    public ?string $str_cutout = null;
    public ?string $str_description_en = null;
    public ?string $str_height = null;
    public ?string $str_nationality = null;
    public ?string $str_player = null;
    public ?string $str_position = null;
    public ?string $str_sport = null;
    public ?string $str_team = null;
    public ?string $str_thumb = null;
    public ?string $str_weight = null;
}

/** Request payload for Player#list. */
class PlayerListMatch
{
    public string $api_key;
}

/** Team entity data model. */
class Team
{
    public ?string $id_team = null;
    public ?string $int_formed_year = null;
    public ?string $int_stadium_capacity = null;
    public ?string $str_alternate = null;
    public ?string $str_description_en = null;
    public ?string $str_league = null;
    public ?string $str_sport = null;
    public ?string $str_stadium = null;
    public ?string $str_stadium_location = null;
    public ?string $str_team = null;
    public ?string $str_team_badge = null;
    public ?string $str_team_jersey = null;
    public ?string $str_website = null;
}

/** Request payload for Team#list. */
class TeamListMatch
{
    public string $api_key;
}

