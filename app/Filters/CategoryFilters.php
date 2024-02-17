<?php

namespace App\Filters;

class CategoryFilters extends QueryFilter
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

    public function code($query = "")
    {
        return $this->builder->where('code', 'like', '%' . $query . '%');
    }

    public function status($query = 0)
    {
        return $this->builder->where('is_active', $query);
    }
}
