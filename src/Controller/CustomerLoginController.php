<?php

namespace App\Controller;

use App\Entity\Customer;
use App\Form\CustomerLoginType;
use App\Repository\CustomerRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
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
        //$customer = new Customer();
        $form = $this->createForm(CustomerLoginType::class);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            
            // do anything else you need here, like send an email
            $customer = $customerRepository->findOneBy(['email' => $form->get('email')->getData()]);
            //dd($customer);
            
            $this->addFlash('notice', 'Welcome '. $customer->getName() . '.');

            //return $this->redirectToRoute('app_customers_view');
            return $this->render('customer/customers_view/index.html.twig');                    
        }   
        
        return $this->renderForm('customer/customer_login/index.html.twig', [
            'controller_name' => 'CustomerLoginController',
            'form' => $form,       
        ]);                       
    }

    #[Route('/', name: 'app_customers_view')]
    public function customersView()
    {
        return $this->renderView('customer/customers_view/index.html.twig', []);
    }
}
