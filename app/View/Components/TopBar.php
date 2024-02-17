<?php

namespace App\View\Components;

use App\Settings\HomePageSettings;
use App\Settings\TopBarSettings;
use Illuminate\View\Component;

class TopBar extends Component
{
    /**
     * @var TopBarSettings
     */
    private TopBarSettings $settings;
    /**
     * @var HomePageSettings
     */
    private HomePageSettings $homePageSettings;

    /**
     * Create a new component instance.
     *
     * @param TopBarSettings $settings
     * @param HomePageSettings $homePageSettings
     */
    public function __construct(TopBarSettings $settings, HomePageSettings $homePageSettings)
    {
        $this->settings = $settings;
        $this->homePageSettings = $homePageSettings;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.top-bar', [
            'topBar' => $this->settings,
            'homePageSettings' => $this->homePageSettings
        ]);
    }
}
