<?php

namespace App\Models;

use App\Filters\QueryFilter;
use App\Settings\PaymentSettings;
use App\Settings\TaxSettings;
use App\Traits\SecureDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class Plan extends Model
{
    use HasFactory;
    use SoftDeletes;
    use SecureDeletes;

    /*
    |--------------------------------------------------------------------------
    | GLOBAL VARIABLES
    |--------------------------------------------------------------------------
    */

    protected $table = 'plans';

    protected $guarded = [];

    protected $casts = [
        'has_trial' => 'boolean',
        'has_discount' => 'boolean',
        'feature_restrictions' => 'boolean',
        'is_popular' => 'boolean',
        'is_active' => 'boolean'
    ];

    /*
    |--------------------------------------------------------------------------
    | FUNCTIONS
    |--------------------------------------------------------------------------
    */

    protected static function booted()
    {
        static::creating(function ($subCategory) {
            $subCategory->attributes['code'] = 'plan_'.Str::random(11);
        });
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

    public function features()
    {
        return $this->belongsToMany(Feature::class, 'plan_features', 'plan_id', 'feature_id');
    }

    public function subscriptions()
    {
        return $this->hasMany(Subscription::class);
    }

    public function payments()
    {
        return $this->hasMany(Payment::class);
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

    public function scopeActive($query)
    {
        return $query->where('is_active', 1);
    }

    /*
    |--------------------------------------------------------------------------
    | ACCESSORS
    |--------------------------------------------------------------------------
    */

    public function getFullNameAttribute()
    {
        return "{$this->category->name} {$this->name} - {$this->duration} Months Plan";
    }

    public function getFormattedPriceAttribute()
    {
        return formatPrice($this->price, app(PaymentSettings::class)->currency_symbol, app(PaymentSettings::class)->currency_symbol_position);
    }

    public function getDiscountedPriceAttribute()
    {
        return $this->has_discount ? $this->price - ($this->price * $this->discount_percentage / 100) : 0;
    }

    public function getFormattedDiscountedPriceAttribute()
    {
        return formatPrice($this->discounted_price, app(PaymentSettings::class)->currency_symbol, app(PaymentSettings::class)->currency_symbol_position);
    }

    public function getTotalPriceAttribute()
    {
        return $this->price * $this->duration;
    }

    public function getFormattedTotalPriceAttribute()
    {
        return formatPrice($this->total_price, app(PaymentSettings::class)->currency_symbol, app(PaymentSettings::class)->currency_symbol_position);
    }

    public function getTotalDiscountedPriceAttribute()
    {
        return $this->has_discount ? $this->discounted_price * $this->duration : 0;
    }

    public function getFormattedTotalDiscountedPriceAttribute()
    {
        return formatPrice($this->total_discounted_price, app(PaymentSettings::class)->currency_symbol, app(PaymentSettings::class)->currency_symbol_position);
    }

    /*
    |--------------------------------------------------------------------------
    | MUTATORS
    |--------------------------------------------------------------------------
    */
}
