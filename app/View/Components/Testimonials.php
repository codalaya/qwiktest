<?php

namespace App\View\Components;

use App\Settings\TestimonialSettings;
use Illuminate\View\Component;

class Testimonials extends Component
{
    /**
     * @var TestimonialSettings
     */
    private TestimonialSettings $testimonials;

    /**
     * Create a new component instance.
     *
     * @param TestimonialSettings $testimonials
     */
    public function __construct(TestimonialSettings $testimonials)
    {
        $this->testimonials = $testimonials;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.testimonials', $this->testimonials);
    }
}
