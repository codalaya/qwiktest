<?php
namespace App\Models;

use App\Filters\QueryFilter;
use App\Traits\SecureDeletes;
use Cviebrock\EloquentSluggable\Sluggable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;
use Illuminate\Database\Eloquent\Builder;
use Spatie\SchemalessAttributes\SchemalessAttributesTrait;

class Exam extends Model
{
    use HasFactory;
    use SoftDeletes;
    use Sluggable;
    use SecureDeletes;
    use SchemalessAttributesTrait;

    /*
    |--------------------------------------------------------------------------
    | GLOBAL VARIABLES
    |--------------------------------------------------------------------------
    */

    protected $table = 'exams';

    protected $guarded = [];

    protected $casts = [
        'is_paid' => 'boolean',
        'is_active' => 'boolean',
        'is_private' => 'boolean',
        'can_redeem' => 'boolean'
    ];

    protected $schemalessAttributes = [
        'settings',
    ];

    /*
    |--------------------------------------------------------------------------
    | FUNCTIONS
    |--------------------------------------------------------------------------
    */

    public function sluggable(): array
    {
        return [
            'slug' => [
                'source' => 'title'
            ]
        ];
    }

    protected static function booted()
    {
        static::creating(function ($subCategory) {
            $subCategory->attributes['code'] = 'exam_'.Str::random(11);
        });
    }

    public function updateMeta()
    {
        $this->total_questions = $this->questions()->count();
        $this->total_duration = $this->examSections()->sum('total_duration');
        $this->total_marks = $this->examSections()->sum('total_marks');
        $this->update();
    }

    /*
    |--------------------------------------------------------------------------
    | RELATIONS
    |--------------------------------------------------------------------------
    */

    public function subCategory()
    {
        return $this->belongsTo(SubCategory::class);
    }

    public function examSections()
    {
        return $this->hasMany(ExamSection::class);
    }

    public function examSchedules()
    {
        return $this->hasMany(ExamSchedule::class);
    }

    public function questions()
    {
        return $this->belongsToMany(Question::class, 'exam_questions', 'exam_id', 'question_id');
    }

    public function sessions()
    {
        return $this->hasMany(ExamSession::class);
    }

    public function examType()
    {
        return $this->belongsTo(ExamType::class);
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

    public function scopeWithSettings(): Builder
    {
        return $this->settings->modelCast();
    }

    public function scopePublished($query)
    {
        $query->where('is_active', true);
    }

    public function scopeIsPublic($query)
    {
        $query->where('is_private', false);
    }

    public function scopeIsPrivate($query)
    {
        $query->where('is_private', true);
    }

    /*
    |--------------------------------------------------------------------------
    | ACCESSORS
    |--------------------------------------------------------------------------
    */

    /*
    |--------------------------------------------------------------------------
    | MUTATORS
    |--------------------------------------------------------------------------
    */

}
