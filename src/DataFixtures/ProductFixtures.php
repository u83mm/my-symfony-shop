<?php

namespace App\DataFixtures;

use App\Entity\Product;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;

class ProductFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        // $product = new Product();
        // $manager->persist($product);
       
        /*$faker = Factory::create();                

        for ($i=0; $i < 10; $i++) { 
            $product = new Product();
            $product->setName($faker->realTextBetween(5, 10));
            $product->setDescription($faker->text());
            $product->setPrice(number_format(rand(1, 1000) / rand(1, 5), 2, "."));
            $product->setImage("ruta");

            $manager->persist($product);
            $manager->flush();
        }*/   
    }
}