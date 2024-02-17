<?php


namespace App\Filters;


class ExamScheduleFilters extends QueryFilter
{
    /*
    |--------------------------------------------------------------------------
    | DEFINE ALL COLUMN FILTERS BELOW
    |--------------------------------------------------------------------------
    */

    function status($query)
    {
        return $this->builder->where('status', $query);
    }
}
