<?php

namespace App\View\Components;

use App\Settings\FooterSettings;
use App\Settings\HomePageSettings;
use App\Settings\SiteSettings;
use Illuminate\View\Component;

class Footer extends Component
{
    /**
     * @var FooterSettings
     */
    private FooterSettings $footerSettings;
    /**
     * @var HomePageSettings
     */
    private HomePageSettings $homePageSettings;

    /**
     * Create a new component instance.
     *
     * @param FooterSettings $footerSettings
     * @param HomePageSettings $homePageSettings
     */
    public function __construct(FooterSettings $footerSettings, HomePageSettings $homePageSettings)
    {
        $this->footerSettings = $footerSettings;
        $this->homePageSettings = $homePageSettings;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.footer', [
            'footerSettings' => $this->footerSettings,
            'siteSettings' => app(SiteSettings::class)->toArray(),
            'homePageSettings' => $this->homePageSettings
        ]);
    }
}
