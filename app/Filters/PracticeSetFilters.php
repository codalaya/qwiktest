<?php


namespace App\Filters;

class PracticeSetFilters extends QueryFilter
{
    /*
    |--------------------------------------------------------------------------
    | DEFINE ALL COLUMN FILTERS BELOW
    |--------------------------------------------------------------------------
    */

    public function title($query)
    {
        return $this->builder->where('title', 'like', '%' . $query . '%');
    }

    public function code($query)
    {
        return $this->builder->where('code', 'like', '%' . $query . '%');
    }

    function sub_category_id($query)
    {
        return $this->builder->where('sub_category_id', $query);
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
