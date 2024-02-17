<?php


namespace App\Repositories;

class VideoRepository
{
    /**
     * Practice Video Configuration Steps
     *
     * @param string $active
     * @return array[]
     */
    public function getSteps($active = 'skill')
    {
        return [
            [
                'step' => 1,
                'key' => 'skill',
                'title' => __('Choose Skill'),
                'status' => $active == 'skill' ? 'active' : 'inactive',
                'url' => route('practice.configure_videos')
            ],
            [
                'step' => 2,
                'key' => 'videos',
                'title' => __('Add/Remove Videos'),
                'status' => $active == 'videos' ? 'active' : 'inactive',
                'url' => ''
            ],
        ];
    }
}
