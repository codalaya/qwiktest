<?php


namespace App\Repositories;

use App\Models\Tag;
use Illuminate\Support\Str;

class TagRepository
{
    /**
     * Check if tags exists, otherwise create
     * @param $tags
     * @return bool
     */
    public function createIfNotExists($tags)
    {
        $existingTags = Tag::whereIn('name', $tags)->pluck('name');
        $newTags = [];

        $diff = collect($tags)->diff($existingTags);
        foreach (array_values($diff->toArray()) as $tag){
            array_push($newTags, [
                'name' => $tag,
                'slug' => Str::slug($tag),
            ]);
        }

        if($newTags) {
            Tag::insert($newTags);
        }

        return true;
    }
}
