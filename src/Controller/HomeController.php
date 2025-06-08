<?php

namespace App\Controller;

use App\Entity\Product;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/{_locale}', name: 'app_home')]
    public function index(ManagerRegistry $mr, Session $session, Request $request): Response
    {
        // Test for a current locale
        $productGetLocaleDescription = "get" . ucfirst($request->getLocale()) . 'Description';        
        
        if($mr->getRepository(Product::class)->findAll()) {
            foreach ($mr->getRepository(Product::class)->findAll() as $product) {
                // Set current product description language
                $product->setDescription($product->getProductDescription()->$productGetLocaleDescription() ?? "");
            }
        }

        $cart = $session->get('cart');

        return $this->render('home/index.html.twig', [
            'controller_name' => 'HomeController',
            'products' => $mr->getRepository(Product::class)->findAll(),
            'cart' => $cart,                                            
        ]);                    
    }
}
