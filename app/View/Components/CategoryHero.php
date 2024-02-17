<?php

namespace App\View\Components;

use App\Models\Category;
use App\Settings\HeroSettings;
use Illuminate\View\Component;

class CategoryHero extends Component
{
    /**
     * @var HeroSettings
     */
    private HeroSettings $hero;
    private array $category;
    private $price;

    /**
     * Create a new component instance.
     *
     * @param array $category
     * @param $price
     * @param HeroSettings $hero
     */
    public function __construct(array $category, $price, HeroSettings $hero)
    {
        $this->hero = $hero;
        $this->category = $category;
        $this->price = $price;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.category-hero', [
            'hero' => $this->hero,
            'category' => $this->category,
            'least_price' => $this->price
        ]);
    }
}
