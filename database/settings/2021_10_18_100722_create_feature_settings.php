<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class CreateFeatureSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('features.title', 'Better Learning. Better Results.');
        $this->migrator->add('features.subtitle', 'One platform for all your learning needs');
        $this->migrator->add('features.feature1', ['Top Quality Questions', 'All questions and solutions, designed by top exam experts, based on latest patterns and actual exam level', 'https://via.placeholder.com/48x48']);
        $this->migrator->add('features.feature2',  ['Detailed Analysis', 'Know your weaknesses, strengths and everything else that you need to know to improve your score and rank.', 'https://via.placeholder.com/48x48']);
        $this->migrator->add('features.feature3',  ['Live Quizzes', 'Get your All-India Rank and feel the thrill of a real-exam. Groom your pressure handling and time management skills.', 'https://via.placeholder.com/48x48']);
        $this->migrator->add('features.feature4',  ['Learning Videos', 'Become lifelong learners with best teachers, engaging video lessons and personalised learning journeys', 'https://via.placeholder.com/48x48']);
    }
}
