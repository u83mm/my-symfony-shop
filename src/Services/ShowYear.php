<?php
    namespace App\Services;

    class ShowYear {
        private $year;

        public function __construct()
        {
            $this->year = date('Y');
        }

        public function showYear(): string
        {
            return $this->year;
        }
    }
?>