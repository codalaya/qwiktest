<?php

namespace App\View\Components;

use App\Settings\SiteSettings;
use Illuminate\View\Component;

class Navbar extends Component
{
    /**
     * @var SiteSettings
     */
    private SiteSettings $siteSettings;

    /**
     * Create a new component instance.
     *
     * @param SiteSettings $siteSettings
     */
    public function __construct(SiteSettings $siteSettings)
    {
        //
        $this->siteSettings = $siteSettings;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.navbar', [
            'siteSettings' => $this->siteSettings
        ]);
    }
}
