<?php

namespace App\View\Components;

use App\Settings\FeatureSettings;
use Illuminate\View\Component;

class Features extends Component
{
    /**
     * @var FeatureSettings
     */
    private FeatureSettings $features;

    /**
     * Create a new component instance.
     *
     * @param FeatureSettings $features
     */
    public function __construct(FeatureSettings $features)
    {
        $this->features = $features;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.features', $this->features);
    }
}
