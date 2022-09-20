<?php

namespace App\Controller;

use App\Entity\Customer;
use App\Repository\CustomerRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/customers')]
class CustomerLoginController extends AbstractController
{
    #[Route('/login', name: 'app_customer_login')]
    public function index(Request $request, CustomerRepository $customerRepository, EntityManagerInterface $entityManager, UserPasswordHasherInterface $userPasswordHasher): Response
    {          
        return $this->render('customer/customer_login/index.html.twig', [
            'controller_name' => 'CustomerLoginController',             
        ]);
    }

    #[Route('/', name: 'app_customers_view')]
    public function customersView()
    {
        return $this->renderView('customer/customers_view/index.html.twig', []);
    }
}
