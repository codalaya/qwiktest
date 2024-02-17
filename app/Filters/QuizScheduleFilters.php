<?php


namespace App\Filters;


class QuizScheduleFilters extends QueryFilter
{
    /*
    |--------------------------------------------------------------------------
    | DEFINE ALL COLUMN FILTERS BELOW
    |--------------------------------------------------------------------------
    */

    public function status($query = "")
    {
        return $this->builder->where('status', $query);
    }
}
