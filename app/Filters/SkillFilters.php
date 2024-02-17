<?php


namespace App\Filters;

class SkillFilters extends QueryFilter
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

    function section_id($query)
    {
        return $this->builder->where('section_id', $query);
    }

    public function status($query = 0)
    {
        return $this->builder->where('is_active', $query);
    }
}
