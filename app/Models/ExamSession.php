<?php

namespace App\Models;

use App\Traits\SecureDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;
use Spatie\SchemalessAttributes\SchemalessAttributesTrait;

class ExamSession extends Model
{
    use HasFactory;
    use SchemalessAttributesTrait;
    use SoftDeletes;
    use SecureDeletes;
    /*
    |--------------------------------------------------------------------------
    | GLOBAL VARIABLES
    |--------------------------------------------------------------------------
    */

    protected $guarded = [];

    protected $casts = [
        'starts_at' => 'datetime',
        'ends_at' => 'datetime',
        'completed_at' => 'datetime',
        'exam_sections' => 'array',
    ];

    protected $schemalessAttributes = [
        'results',
    ];

    /*
    |--------------------------------------------------------------------------
    | FUNCTIONS
    |--------------------------------------------------------------------------
    */

    protected static function booted()
    {
        static::creating(function ($category) {
            $category->attributes['code'] = Str::uuid();
        });
    }

    /*
    |--------------------------------------------------------------------------
    | RELATIONS
    |--------------------------------------------------------------------------
    */

    public function exam()
    {
        return $this->belongsTo(Exam::class, 'exam_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function sections()
    {
        return $this->belongsToMany(ExamSection::class, 'exam_session_sections')
            ->withPivot('sno', 'name', 'status', 'section_id', 'starts_at', 'ends_at', 'total_time_taken', 'current_question', 'results');
    }

    public function questions()
    {
        return $this->belongsToMany(Question::class, 'exam_session_questions')
            ->withPivot('status', 'exam_section_id', 'original_question', 'options', 'is_correct', 'time_taken', 'user_answer', 'correct_answer', 'marks_earned', 'marks_deducted');
    }

    public function examSchedule()
    {
        return $this->belongsTo(ExamSchedule::class);
    }

    /*
    |--------------------------------------------------------------------------
    | SCOPES
    |--------------------------------------------------------------------------
    */

    public function scopePending($query)
    {
        return $query->where('status', '=', 'started');
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
