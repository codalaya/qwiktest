<?php

namespace App\View\Components;

use App\Settings\HeroSettings;
use Illuminate\View\Component;

class Hero extends Component
{
    /**
     * @var HeroSettings
     */
    private HeroSettings $hero;

    /**
     * Create a new component instance.
     *
     * @param HeroSettings $hero
     */
    public function __construct(HeroSettings $hero)
    {
        $this->hero = $hero;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.hero', $this->hero);
    }
}
