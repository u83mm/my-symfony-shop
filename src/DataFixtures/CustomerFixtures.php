<?php

namespace App\DataFixtures;

use App\Entity\Customer;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;

class CustomerFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        // $product = new Product();
        // $manager->persist($product);

        $faker = Factory::create();                

        for ($i=0; $i < 10; $i++) { 
            $customer = new Customer();

            $customer->setName($faker->name());
            $customer->setFirstName($faker->firstName());
            $customer->setLastName($faker->lastName());
            $customer->setAddress($faker->address());
            $customer->setState($faker->country());
            $customer->setCity($faker->city());
            $customer->setEmail($faker->email());
            $customer->setPassword($faker->password());
            

            $manager->persist($customer);
            $manager->flush();
        }    
    }
}
