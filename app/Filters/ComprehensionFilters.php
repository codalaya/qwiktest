<?php


namespace App\Filters;


class ComprehensionFilters extends QueryFilter
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

    public function status($query = 0)
    {
        return $this->builder->where('is_active', $query);
    }
}
