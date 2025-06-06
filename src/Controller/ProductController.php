<?php

namespace App\Controller;

use App\Entity\Product;
use App\Entity\ProductDescription;
use App\Form\ProductType;
use App\Repository\ProductRepository;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;
use Symfony\Contracts\Translation\TranslatorInterface;

#[Route('/{_locale}/product')]
class ProductController extends AbstractController
{
    public function __construct(private TranslatorInterface $translator)
    {
        
    }
    #[IsGranted('ROLE_ADMIN')]
    #[Route('/', name: 'app_product_index', methods: ['GET'])]
    public function index(ProductRepository $productRepository, Session $session): Response
    {
        // Test for a current locale
        $productGetLocaleDescription = "get" . ucfirst($session->get('_locale')) . 'Description';                                

        $cart = $session->get('cart');       

        foreach ($productRepository->findAll() as $product) {
            // Set current product description language
            $product->setDescription($product->getProductDescription()->$productGetLocaleDescription() ?? "");
        }

        return $this->render('product/index.html.twig', [
            'products' => $productRepository->findAll(),
            'cart' => $cart,
        ]);
    }

    #[IsGranted('ROLE_ADMIN')]
    #[Route('/new', name: 'app_product_new', methods: ['GET', 'POST'])]
    public function new(Request $request, ProductRepository $productRepository, SluggerInterface $slugger): Response
    {
        // Test for a current locale and set ProductDescription methods       
        $productSetLocaleDescription = "set" . ucfirst($request->getLocale()) . 'Description';

        $product = new Product();
        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            try {
                $img = $form->get('image')->getData();

                if ($img) {                                               
                    $filesystem = new Filesystem();    
                    $imgToRemove = $product->getImage();        
                    if($imgToRemove) $filesystem->remove($this->getParameter('images_directory') . "/" . $imgToRemove);

                    $originalFilename = pathinfo($img->getClientOriginalName(), PATHINFO_FILENAME);
                    $safeFilename = $slugger->slug($originalFilename);
                    $newFilename = $safeFilename.'-'.uniqid().'.'.$img->guessExtension();

                    // Move the file to the directory where products are stored
                    $img->move(
                        $this->getParameter('images_directory'),
                        $newFilename
                    );

                    // updates the 'image' property to store the IMG file name
                    // instead of its contents
                    $product->setImage($newFilename);
                }                                

                // Save current product description language
                $product->setProductDescription(new ProductDescription());
                $product->getProductDescription()->$productSetLocaleDescription($product->getDescription());
                $productRepository->add($product, true);

                $this->addFlash('notice', ucfirst($this->translator->trans('saved product')));

                return $this->redirectToRoute('app_product_index', [], Response::HTTP_SEE_OTHER);

            } catch (\Throwable $th) {
                if($this->isGranted('ROLE_ADMIN')) {                   
                    $this->addFlash('error', $th->getMessage());
                }
                else {
                    $this->addFlash('error', ucfirst($this->translator->trans('admin alert')));
                }
            }
            
        }

        return $this->render('product/new.html.twig', [
            'product' => $product,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_product_show', methods: ['GET'])]
    public function show(Product $product, Session $session): Response
    {
        try {                        
            // Test for a current locale
            $productGetLocaleDescription = "get" . ucfirst($session->get('_locale')) . 'Description';                        

            // Set product description
            $product->setDescription($product->getProductDescription()->$productGetLocaleDescription() ?? "");
            
        } catch (\Throwable $th) {
            if($this->isGranted('ROLE_ADMIN')) {
                $this->addFlash('error', $th->getMessage());
            }
            else {
                $this->addFlash('error', ucfirst($this->translator->trans('admin alert')));
            }            
        }
        return $this->render('product/show.html.twig', [
            'product'   => $product,
            'cart'      => $session->get('cart'),
        ]);
    }

    #[IsGranted('ROLE_ADMIN')]
    #[Route('/{id}/edit', name: 'app_product_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Product $product, ProductRepository $productRepository, SluggerInterface $slugger): Response
    {
        // Test for a current locale and set ProductDescription methods
        $productGetLocaleDescription = "get" . ucfirst($request->getLocale()) . 'Description';
        $productSetLocaleDescription = "set" . ucfirst($request->getLocale()) . 'Description';

        // Set product description
        $product->setDescription($product->getProductDescription()->$productGetLocaleDescription() ?? "");

        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);                

        if ($form->isSubmitted() && $form->isValid()) {
            try {                                
                $img = $form->get('image')->getData();
            
                if ($img) {                
                    $filesystem = new Filesystem();    
                    $imgToRemove = $product->getImage();        
                    if($imgToRemove) $filesystem->remove($this->getParameter('images_directory') . "/" . $imgToRemove);

                    $originalFilename = pathinfo($img->getClientOriginalName(), PATHINFO_FILENAME);
                    $safeFilename = $slugger->slug($originalFilename);
                    $newFilename = $safeFilename.'-'.uniqid().'.'.$img->guessExtension();

                    // Move the file to the directory where products are stored
                    try {
                        $img->move(
                            $this->getParameter('images_directory'),
                            $newFilename
                        );
                    } catch (FileException $e) {                        
                        $this->addFlash('warning', "The image can't be uploaded.");                        
                    }

                    // updates the 'image' property to store the IMG file name
                    // instead of its contents
                    $product->setImage($newFilename);
                }

                // Save current language product description
                $product->getProductDescription()->$productSetLocaleDescription($product->getDescription());
                $productRepository->add($product, true);

                $this->addFlash('notice', ucfirst($this->translator->trans('updated product')));                

            } catch (\Throwable $th) {
                if($this->isGranted('ROLE_ADMIN')) {
                    $this->addFlash('error', ucfirst($th->getMessage()));
                }
                else {
                    $this->addFlash('error', $this->translator->trans('admin alert'));
                }                
            }
        }

        return $this->render('product/edit.html.twig', [
            'product' => $product,
            'form' => $form,
        ]);
    }

    #[IsGranted('ROLE_ADMIN')]
    #[Route('/{id}/delete', name: 'app_product_delete', methods: ['POST'])]
    public function delete(Request $request, Product $product, ProductRepository $productRepository): Response
    {               
        try {                     
            if ($this->isCsrfTokenValid('delete'.$product->getId(), $request->request->get('_token'))) {
                $filesystem = new Filesystem();
                $filesystem->remove($this->getParameter('images_directory') . "/". $product->getImage());
                
                $productRepository->remove($product, true);
                $this->addFlash('notice', ucfirst($this->translator->trans('delected product')));
            }

            return $this->redirectToRoute('app_product_index', [], Response::HTTP_SEE_OTHER);

        } catch (\Throwable $th) {
            if($this->isGranted('ROLE_ADMIN')) {
                $this->addFlash('error', $th->getMessage());
            }
            else {
                $this->addFlash('error', ucfirst($this->translator->trans('admin alert')));
            }

            return $this->redirectToRoute('app_product_index', [], Response::HTTP_SEE_OTHER);
        }
    }
}
