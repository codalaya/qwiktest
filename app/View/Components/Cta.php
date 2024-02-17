<?php

namespace App\View\Components;

use App\Settings\CtaSettings;
use Illuminate\View\Component;

class Cta extends Component
{
    /**
     * @var CtaSettings
     */
    private CtaSettings $cta;

    /**
     * Create a new component instance.
     *
     * @param CtaSettings $cta
     */
    public function __construct(CtaSettings $cta)
    {
        //
        $this->cta = $cta;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.cta', $this->cta);
    }
}
