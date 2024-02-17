<?php


namespace App\Filters;


class SubscriptionFilters extends QueryFilter
{
    public function code($query = "")
    {
        return $this->builder->where('code', 'like', '%' . $query . '%');
    }

    public function payment($query = '')
    {
        if ($query !== '') {
            return $this->builder->whereHas('payment', function ($q) use ($query) {
                $q->where('payments.payment_id', 'like', "%{$query}%");
            });
        }
        return null;
    }

    public function plan($query = null)
    {
        return $this->builder->where('plan_id', '=', $query);
    }

    public function status($status = "")
    {
        return $this->builder->where('state', $status);
    }
}
