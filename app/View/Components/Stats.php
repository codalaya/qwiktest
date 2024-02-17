<?php

namespace App\View\Components;

use App\Settings\StatSettings;
use Illuminate\View\Component;

class Stats extends Component
{
    /**
     * @var StatSettings
     */
    private StatSettings $stats;

    /**
     * Create a new component instance.
     *
     * @param StatSettings $stats
     */
    public function __construct(StatSettings $stats)
    {
        //
        $this->stats = $stats;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.stats', $this->stats);
    }
}
