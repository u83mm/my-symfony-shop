<?php

namespace App\Controller;

use App\Entity\Customer;
use App\Form\Customer1Type;
use App\Repository\CustomerRepository;
use Doctrine\ORM\EntityManagerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/customer')]
class CustomerController extends AbstractController
{

    /**
     * Require ROLE_ADMIN for this actions
     */
    #[IsGranted('ROLE_ADMIN')]
    #[Route('/', name: 'app_customer_index', methods: ['GET'])]
    public function index(CustomerRepository $customerRepository): Response
    {
        return $this->render('customer/index.html.twig', [
            'customers' => $customerRepository->findAll(),
        ]);
    }

    #[Route('/new', name: 'app_customer_new', methods: ['GET', 'POST'])]
    public function new(Request $request, UserPasswordHasherInterface $userPasswordHasher, EntityManagerInterface $entityManager, CustomerRepository $customerRepository): Response
    {
        $customer = new Customer();
        $form = $this->createForm(Customer1Type::class, $customer);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $customer->setPassword(
                $userPasswordHasher->hashPassword(
                    $customer,
                    $form->get('plainPassword')->getData()
                )
            );

            $customerRepository->add($customer, true);

            $entityManager->persist($customer);
            $entityManager->flush();
            
            $this->addFlash('notice', 'Registration successfully!.');

            return $this->redirectToRoute('app_customer_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('customer/new.html.twig', [
            'customer' => $customer,
            'form' => $form,
        ]);
    }


    /**
     * Require ROLE_USER for this actions
     */
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    #[Route('/{id}', name: 'app_customer_show', methods: ['GET'])]
    public function show(Customer $customer): Response
    {
        return $this->render('customer/show.html.twig', [
            'customer' => $customer,
        ]);
    }

    /**
     * Require ROLE_USER for this actions
     */
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    #[Route('/{id}/edit', name: 'app_customer_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Customer $customer, CustomerRepository $customerRepository, UserPasswordHasherInterface $userPasswordHasher, EntityManagerInterface $entityManager): Response
    {
        $form = $this->createForm(Customer1Type::class, $customer);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $customer->setPassword(
                $userPasswordHasher->hashPassword(
                    $customer,
                    $form->get('password')->getData()
                )
            );
            $customerRepository->add($customer, true);

            $entityManager->persist($customer);
            $entityManager->flush();

            $this->addFlash('notice', 'Registry updated successfully.');

            return $this->redirectToRoute('app_customer_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('customer/edit.html.twig', [
            'customer' => $customer,
            'form' => $form,
        ]);
    }


    /**
     * Require ROLE_ADMIN for this actions
     */
    #[IsGranted('ROLE_ADMIN')]
    #[Route('/{id}', name: 'app_customer_delete', methods: ['POST'])]
    public function delete(Request $request, Customer $customer, CustomerRepository $customerRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$customer->getId(), $request->request->get('_token'))) {
            $customerRepository->remove($customer, true);
        }

        return $this->redirectToRoute('app_customer_index', [], Response::HTTP_SEE_OTHER);
    }
}
