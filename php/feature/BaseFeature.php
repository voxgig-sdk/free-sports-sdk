<?php
declare(strict_types=1);

// FreeSports SDK base feature

class FreeSportsBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    // Positions this feature when added via the client `extend` option:
    // "__before__" / "__after__" / "__replace__" name an already-added
    // feature (mirrors the ts feature `_options`). Declared so setting it
    // on an extension instance avoids the dynamic-property deprecation.
    public ?array $_options = null;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(FreeSportsContext $ctx, array $options): void {}
    public function PostConstruct(FreeSportsContext $ctx): void {}
    public function PostConstructEntity(FreeSportsContext $ctx): void {}
    public function SetData(FreeSportsContext $ctx): void {}
    public function GetData(FreeSportsContext $ctx): void {}
    public function GetMatch(FreeSportsContext $ctx): void {}
    public function SetMatch(FreeSportsContext $ctx): void {}
    public function PrePoint(FreeSportsContext $ctx): void {}
    public function PreSpec(FreeSportsContext $ctx): void {}
    public function PreRequest(FreeSportsContext $ctx): void {}
    public function PreResponse(FreeSportsContext $ctx): void {}
    public function PreResult(FreeSportsContext $ctx): void {}
    public function PreDone(FreeSportsContext $ctx): void {}
    public function PreUnexpected(FreeSportsContext $ctx): void {}
}
