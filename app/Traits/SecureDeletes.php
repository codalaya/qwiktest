<?php


namespace App\Traits;

trait SecureDeletes
{
    /**
     * Delete only when there is no reference to other models.
     *
     * @param array $relations
     */
    public function secureDelete(String ...$relations)
    {
        $hasRelation = false;
        foreach ($relations as $relation) {
            if ($this->$relation()->withTrashed()->count()) {
                $hasRelation = true;
                break;
            }
        }

        if ($hasRelation) {
            $this->delete();
        } else {
            $this->forceDelete();
        }
    }

    /**
     * Check whether the model has any relation and can deletable.
     *
     * @param array $relations
     * @return bool
     */
    public function canSecureDelete(String ...$relations)
    {
        $hasRelation = false;
        foreach ($relations as $relation) {
            if ($this->$relation()->withTrashed()->count()) {
                $hasRelation = true;
                break;
            }
        }

        if ($hasRelation) {
            return false;
        } else {
            return true;
        }
    }
}
