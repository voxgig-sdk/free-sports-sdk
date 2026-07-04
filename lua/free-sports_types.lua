-- Typed models for the FreeSports SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
-- params (op.<name>.points[].args.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Event
---@field date_event? string
---@field id_event? string
---@field int_away_score? string
---@field int_home_score? string
---@field str_away_team? string
---@field str_event? string
---@field str_home_team? string
---@field str_league? string
---@field str_sport? string
---@field str_status? string
---@field str_thumb? string
---@field str_time? string
---@field str_venue? string
---@field str_video? string

---@class EventListMatch
---@field api_key string

---@class League
---@field id_league? string
---@field int_formed_year? string
---@field str_badge? string
---@field str_country? string
---@field str_description_en? string
---@field str_league? string
---@field str_league_alternate? string
---@field str_logo? string
---@field str_sport? string
---@field str_website? string

---@class LeagueListMatch
---@field api_key string

---@class Player
---@field date_born? string
---@field id_player? string
---@field str_cutout? string
---@field str_description_en? string
---@field str_height? string
---@field str_nationality? string
---@field str_player? string
---@field str_position? string
---@field str_sport? string
---@field str_team? string
---@field str_thumb? string
---@field str_weight? string

---@class PlayerListMatch
---@field api_key string

---@class Team
---@field id_team? string
---@field int_formed_year? string
---@field int_stadium_capacity? string
---@field str_alternate? string
---@field str_description_en? string
---@field str_league? string
---@field str_sport? string
---@field str_stadium? string
---@field str_stadium_location? string
---@field str_team? string
---@field str_team_badge? string
---@field str_team_jersey? string
---@field str_website? string

---@class TeamListMatch
---@field api_key string

local M = {}

return M
