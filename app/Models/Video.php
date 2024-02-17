<?php

namespace App\Models;

use App\Filters\QueryFilter;
use App\Traits\SecureDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;
use Znck\Eloquent\Traits\BelongsToThrough;

class Video extends Model
{
    use HasFactory;
    use SoftDeletes;
    use SecureDeletes;
    use BelongsToThrough;

    /*
    |--------------------------------------------------------------------------
    | GLOBAL VARIABLES
    |--------------------------------------------------------------------------
    */

    protected $table = 'videos';

    protected $guarded = [];

    protected $casts = [
        'preferences' => 'object',
        'is_paid' => 'boolean',
        'is_active' => 'boolean',
    ];

    protected $appends = ['video_type_name'];

    /*
    |--------------------------------------------------------------------------
    | FUNCTIONS
    |--------------------------------------------------------------------------
    */

    protected static function booted()
    {
        static::creating(function ($category) {
            $category->attributes['code'] = 'video_'.Str::random(11);
        });
    }

    /*
    |--------------------------------------------------------------------------
    | RELATIONS
    |--------------------------------------------------------------------------
    */

    public function topic()
    {
        return $this->belongsTo(Topic::class);
    }

    public function skill()
    {
        return $this->belongsTo(Skill::class);
    }

    public function section()
    {
        return $this->belongsToThrough(Section::class, Skill::class);
    }

    public function difficultyLevel()
    {
        return $this->belongsTo(DifficultyLevel::class);
    }

    public function tags()
    {
        return $this->morphToMany(Tag::class, 'taggable');
    }

    public function subCategories()
    {
        return $this->belongsToMany(SubCategory::class, 'practice_videos', 'video_id', 'sub_category_id')
            ->withPivot('sort_order');
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
        $query->where('is_active', true);
    }

    /*
    |--------------------------------------------------------------------------
    | ACCESSORS
    |--------------------------------------------------------------------------
    */

    public function getVideoTypeNameAttribute()
    {
        switch ($this->video_type) {
            case 'mp4':
                $name = 'MP4 Video';
                break;
            case 'youtube':
                $name = 'Youtube Video';
                break;
            case 'vimeo':
                $name = 'Vimeo Video';
                break;
            default:
                $name = 'Video';
                break;
        }
        return $name;
    }

    /*
    |--------------------------------------------------------------------------
    | MUTATORS
    |--------------------------------------------------------------------------
    */
}
