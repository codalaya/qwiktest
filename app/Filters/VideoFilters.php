<?php


namespace App\Filters;


class VideoFilters extends QueryFilter
{
    /*
    |--------------------------------------------------------------------------
    | DEFINE ALL COLUMN FILTERS BELOW
    |--------------------------------------------------------------------------
    */

    public function code($query = "")
    {
        return $this->builder->where('code', 'like', '%'.$query.'%');
    }

    public function title($query = "")
    {
        return $this->builder->where('title', 'like', '%'.$query.'%');
    }

    public function status($query = 0)
    {
        return $this->builder->where('is_active', $query);
    }

    public function section($query = '')
    {
        if($query !== '') {
            return $this->builder->whereHas('section', function ($q) use ($query) {
                $q->where('sections.name', 'like', "%{$query}%");
            });
        }
        return null;
    }

    public function skill($query = '')
    {
        if($query !== '') {
            return $this->builder->whereHas('skill', function ($q) use ($query) {
                $q->where('name', 'like', "%{$query}%");
            });
        }
        return null;
    }

    public function topic($query = '')
    {
        if($query !== '') {
            return $this->builder->whereHas('topic', function ($q) use ($query) {
                $q->where('name', 'like', "%{$query}%");
            });
        }
        return null;
    }

    public function difficulty_levels($query = [])
    {
        return $this->builder->whereIn('difficulty_level_id', $query);
    }

    public function tags($query = [])
    {
        if($query !== '') {
            return $this->builder->whereHas('tags', function ($q) use ($query) {
                $q->whereIn('tags.id', $query);
            });
        }
        return null;
    }

}
