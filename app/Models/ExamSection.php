<?php

namespace App\Models;

use App\Traits\SecureDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ExamSection extends Model
{
    use HasFactory;
    use SoftDeletes;
    use SecureDeletes;

    /*
    |--------------------------------------------------------------------------
    | GLOBAL VARIABLES
    |--------------------------------------------------------------------------
    */

    protected $guarded = [];

    protected $casts = [
        'auto_duration' => 'boolean',
        'auto_grading' => 'boolean',
        'enable_negative_marking' => 'boolean',
        'enable_section_cutoff' => 'boolean',
        'assign_examiner' => 'boolean',
        'examined' => 'boolean',
        'approved' => 'boolean',
        'examined_at' => 'datetime',
        'approved_at' => 'datetime',
    ];

    /*
    |--------------------------------------------------------------------------
    | FUNCTIONS
    |--------------------------------------------------------------------------
    */

    public function updateMeta()
    {
        $this->total_questions = $this->questions()->count();

        if ($this->exam->settings->get('auto_duration', true)) {
            $this->total_duration = $this->questions()->sum('default_time');
        }

        if ($this->exam->settings->get('auto_grading', true)) {
            $this->total_marks = $this->questions()->sum('default_marks');
        } else {
            $this->total_marks = $this->questions()->count() * $this->correct_marks;
        }

        $this->update();
    }

    /*
    |--------------------------------------------------------------------------
    | RELATIONS
    |--------------------------------------------------------------------------
    */

    public function exam()
    {
        return $this->belongsTo(Exam::class);
    }

    public function section()
    {
        return $this->belongsTo(Section::class);
    }

    public function questions()
    {
        return $this->belongsToMany(Question::class, 'exam_questions', 'exam_section_id', 'question_id');
    }

    public function examSessions()
    {
        return $this->belongsToMany(ExamSession::class, 'exam_session_sections');
    }

    /*
    |--------------------------------------------------------------------------
    | SCOPES
    |--------------------------------------------------------------------------
    */

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
