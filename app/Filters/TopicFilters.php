<?php


namespace App\Filters;

class TopicFilters extends QueryFilter
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

    function skill_id($query)
    {
        return $this->builder->where('skill_id', $query);
    }

    public function is_active($query)
    {
        return $this->builder->where('is_active', $query);
    }
}
