<?php

namespace App\Filters;

class SectionFilters extends QueryFilter
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

    public function is_active($query)
    {
        return $this->builder->where('is_active', $query);
    }
}
