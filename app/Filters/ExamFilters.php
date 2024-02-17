<?php


namespace App\Filters;


class ExamFilters extends QueryFilter
{
    /*
    |--------------------------------------------------------------------------
    | DEFINE ALL COLUMN FILTERS BELOW
    |--------------------------------------------------------------------------
    */

    public function title($query = "")
    {
        return $this->builder->where('title', 'like', '%' . $query . '%');
    }

    public function code($query = "")
    {
        return $this->builder->where('code', 'like', '%' . $query . '%');
    }

    public function type($query = null)
    {
        return $this->builder->where('exam_type_id', $query);
    }

    public function visibility($query = 0)
    {
        return $this->builder->where('is_private', $query);
    }

    public function status($query = 0)
    {
        return $this->builder->where('is_active', $query);
    }
}
