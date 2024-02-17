<?php

namespace App\Models;

use App\Filters\QueryFilter;
use App\Settings\LocalizationSettings;
use App\Traits\SecureDeletes;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class Subscription extends Model
{
    use HasFactory;
    use SoftDeletes;
    use SecureDeletes;

    /*
    |--------------------------------------------------------------------------
    | GLOBAL VARIABLES
    |--------------------------------------------------------------------------
    */

    protected $table = 'subscriptions';

    protected $guarded = [];

    /*
    |--------------------------------------------------------------------------
    | FUNCTIONS
    |--------------------------------------------------------------------------
    */

    protected static function booted()
    {
        static::creating(function ($subCategory) {
            $subCategory->attributes['code'] = 'subscription_'.Str::random(11);
        });
    }

    public function isActive()
    {
        return Carbon::parse($this->ends_at)->isFuture();
    }

    /*
    |--------------------------------------------------------------------------
    | RELATIONS
    |--------------------------------------------------------------------------
    */

    public function category()
    {
        return $this->morphTo();
    }

    public function plan()
    {
        return $this->belongsTo(Plan::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function payment()
    {
        return $this->belongsTo(Payment::class);
    }

    /*
    |--------------------------------------------------------------------------
    | SCOPES
    |--------------------------------------------------------------------------
    */

    public function scopeFilter($query, QueryFilter $filters)
    {
        return $filters->apply($query);
    }

    /*
    |--------------------------------------------------------------------------
    | ACCESSORS
    |--------------------------------------------------------------------------
    */

    public function getStartsAttribute()
    {
        $localization = app(LocalizationSettings::class);
        return Carbon::parse($this->starts_at)->timezone($localization->default_timezone)->toFormattedDateString();
    }

    public function getEndsAttribute()
    {
        $localization = app(LocalizationSettings::class);
        return Carbon::parse($this->ends_at)->timezone($localization->default_timezone)->toFormattedDateString();
    }

    /*
    |--------------------------------------------------------------------------
    | MUTATORS
    |--------------------------------------------------------------------------
    */
}
