<?php


namespace App\Filters;


class PlanFilters extends QueryFilter
{
    public function name($query = "")
    {
        return $this->builder->where('name', 'like', '%' . $query . '%');
    }

    public function code($query = "")
    {
        return $this->builder->where('code', 'like', '%' . $query . '%');
    }

    public function duration($query = null)
    {
        return $this->builder->where('duration', '=', $query);
    }

    public function status($status = 0)
    {
        return $this->builder->where('is_active', $status);
    }
}
