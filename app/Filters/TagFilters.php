<?php

namespace App\Filters;


class TagFilters extends QueryFilter
{
    /*
    |--------------------------------------------------------------------------
    | DEFINE ALL COLUMN FILTERS BELOW
    |--------------------------------------------------------------------------
    */

    public function name($query = "")
    {
        return $this->builder->where('name', 'like', '%' . $query . '%');
    }

    public function status($query = 0)
    {
        return $this->builder->where('is_active', $query);
    }
}
