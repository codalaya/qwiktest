<?php


namespace App\Filters;

class QuizTypeFilters extends QueryFilter
{
    /*
    |--------------------------------------------------------------------------
    | DEFINE ALL COLUMN FILTERS BELOW
    |--------------------------------------------------------------------------
    */

    public function name($query)
    {
        return $this->builder->where('name', 'like', '%' . $query . '%');
    }

    public function code($query)
    {
        return $this->builder->where('code', 'like', '%' . $query . '%');
    }

    public function status($query = null)
    {
        return $this->builder->where('is_active', $query);
    }
}
