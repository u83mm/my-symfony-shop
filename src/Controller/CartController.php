<?php

namespace App\Controller;

use App\Entity\Order;
use App\Entity\Product;
use App\Entity\User;
use DateTime;
use Doctrine\Persistence\ManagerRegistry;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\Routing\Annotation\Route;

/**
 * Require authentication for this actions
 */
#[IsGranted('IS_AUTHENTICATED_FULLY')]
#[Route('/cart')]
class CartController extends AbstractController
{        
    /**
     * It renders the cart/index.html.twig file.
     * 
     * @return Response A response object.
     */
    #[Route('/', name: 'app_cart')]
    public function index(Session $session): Response{

        return $this->render('cart/index.html.twig', [
            'controller_name' => 'CartController', 
            'cart' => $session->get('cart'),                  
        ]);
    }

    #[Route('/{id}/add', name: 'app_cart_add')]
    public function addToCart(Product $product, Session $session): Response
    {  
        /* Adding the product to the cart. */ 
        $cart = $session->get('cart');

        if (isset($cart[$product->getId()]) && in_array($cart[$product->getId()], $cart)) {            
            $cart[$product->getId()]['qty']++;                      
        } 
        else {           
            $cart[$product->getId()] = [                
                    'id'            => $product->getId(),
                    'name'          => $product->getName(),
                    'description'   => $product->getDescription(),
                    'price'         => $product->getPrice(),
                    'image'         => $product->getImage(),
                    'qty'           => 1,                
            ];                                
        }                                                              
        
        $session->set('cart', $cart);
        $this->addFlash('notice', 'Added product successfully.');
        return $this->redirectToRoute('app_cart_show', [], Response::HTTP_SEE_OTHER);                      
    }

    #[Route('/show', name: 'app_cart_show')]
    public function showCart(Session $session): Response
    {   
        //dd($session->get('cart'));
        $cart = $session->get('cart');
        $price = (float) 0;

        foreach ($cart as $key => $value) {
            $price +=  (float) ($value['price'] * $value['qty']);            
        }

        $taxes = (float) number_format($price * 0.21, 2, ".");
        $totalPrice = $price + $taxes;
        //dd($price);

        return $this->render('cart/show_cart.html.twig', [
            'controller_name'   => 'CartController',
            'cart'              =>  $session->get('cart'),
            'price'             =>  $price,
            'taxex'             =>  $taxes,
            'total'             =>  $totalPrice,                            
        ]);
    }

    #[Route('/{id}/delete', name: 'app_cart_delete')]
    public function removeFromCart($id, Session $session): Response
    {  
        /* Deleting the product from the cart. */
        $cart = $session->get('cart');
        unset($cart[$id]);
        
        $session->set('cart', $cart);

        $this->addFlash('notice', 'Deleted product successfully.');
        return $this->redirectToRoute('app_cart_show', [], Response::HTTP_SEE_OTHER); 
    }

    #[Route('/update', name: 'app_cart_update', methods: ['POST'])]
    public function updateCart(Session $session, Request $request): Response
    {                 
        /* Updating the product in the cart. */        
        //$id = $request->request->get('id');

        $cart = $session->get('cart');
        $cart[$request->request->get('id')]['qty'] = $request->request->get('qty');     
        
        $session->set('cart', $cart);

        $this->addFlash('notice', 'Updated product successfully.');
        return $this->redirectToRoute('app_cart_show', [], Response::HTTP_SEE_OTHER); 
    }
}
