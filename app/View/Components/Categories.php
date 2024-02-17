<?php

namespace App\View\Components;

use App\Models\SubCategory;
use App\Settings\CategorySettings;
use Illuminate\View\Component;

class Categories extends Component
{
    /**
     * @var CategorySettings
     */
    private CategorySettings $categorySettings;

    /**
     * Create a new component instance.
     * @param CategorySettings $categorySettings
     */
    public function __construct(CategorySettings $categorySettings)
    {
        $this->categorySettings = $categorySettings;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.categories', [
            'category' => $this->categorySettings->toArray(),
            'categories' => SubCategory::with('category:id,name')
                ->limit($this->categorySettings->limit)
                ->orderBy('name')
                ->get()
        ]);
    }
}
