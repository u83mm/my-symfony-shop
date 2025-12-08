<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/{_locale}/admin')]
class AdminController extends AbstractController
{
    /**
     * Require ROLE_ADMIN for this actions
     */
    #[IsGranted('ROLE_ADMIN')]
    #[Route('/', name: 'app_admin')]
    public function index(Session $session): Response
    {       
        return $this->render('admin/index.html.twig', [
            'controller_name' => 'AdminController',
            'cart' => $session->get('cart'),
        ]);
    }
}
