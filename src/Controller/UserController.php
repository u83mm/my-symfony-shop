<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\ChangePasswordType;
use App\Form\UserType;
use App\Form\ShowUserType;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Contracts\Translation\TranslatorInterface;

#[Route('/{_locale}/user')]
class UserController extends AbstractController
{ 
    public function __construct(private TranslatorInterface $translator)
    {
        
    }   
    /**
     * Require ROLE_ADMIN for this actions
     */
    #[IsGranted('ROLE_ADMIN')]
    #[Route('/', name: 'app_user_index', methods: ['GET'])]
    public function index(UserRepository $userRepository): Response
    {
        return $this->render('user/index.html.twig', [
            'users' => $userRepository->findAll(),
        ]);
    }
    
    #[IsGranted('ROLE_ADMIN')]
    #[Route('/new', name: 'app_user_new', methods: ['GET', 'POST'])]
    public function new(Request $request, UserRepository $userRepository,EntityManagerInterface $entityManager, UserPasswordHasherInterface $userPasswordHasher): Response
    {
        $user = new User();
        $form = $this->createForm(UserType::class, $user);
        $form->handleRequest($request);        

        if ($form->isSubmitted() && $form->isValid()) {            
            
            try {
                // encode the plain password
                $user->setPassword(
                    $userPasswordHasher->hashPassword(
                        $user,
                        $form->get('password')->getData()
                    )
                );

                $userRepository->add($user, true);

                $entityManager->persist($user);
                $entityManager->flush();

                $this->addFlash('notice', 'User created successfully.');
            
                return $this->redirectToRoute('app_home', [], Response::HTTP_SEE_OTHER); 

            } catch (\Throwable $th) {
                if($this->isGranted('ROLE_ADMIN')) {
                    $this->addFlash('error', $th->getMessage());
                }
                else {
                    $this->addFlash('error', ucfirst($this->translator->trans('alert admin')));
                }
            }         
        }

        return $this->render('user/new.html.twig', [
            'user' => $user,
            'form' => $form,
        ]);
    }

    /**
     * Require ROLE_ADMIN for this actions
     */
    #[IsGranted('ROLE_ADMIN')]
    #[Route('/{id}', name: 'app_user_show', methods: ['GET'])]
    public function show(User $user): Response
    {
        return $this->render('user/show.html.twig', [
            'user' => $user,
        ]);
    }

    /**
     * Require ROLE_ADMIN for this actions
     */
    #[IsGranted('ROLE_ADMIN')]
    #[Route('/{id}/edit', name: 'app_user_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, User $user, UserRepository $userRepository, EntityManagerInterface $entityManager, UserPasswordHasherInterface $userPasswordHasher): Response
    {
        $form = $this->createForm(ShowUserType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            // encode the plain password
            /*$user->setPassword(
                $userPasswordHasher->hashPassword(
                    $user,
                    $form->get('password')->getData()
                )
            );*/

            try {
                $userRepository->add($user, true);

                $entityManager->persist($user);
                $entityManager->flush();

                $this->addFlash('notice', 'User updated successfully.');

                return $this->redirectToRoute('app_user_index', [], Response::HTTP_SEE_OTHER);

            } catch (\Throwable $th) {
                if($this->isGranted(('ROLE_ADMIN'))) {
                    $this->addFlash('error', $th->getMessage());
                }
                else {
                    $this->addFlash('error', ucfirst($this->translator->trans('alert admin')));
                }
            }
        }

        return $this->render('user/edit.html.twig', [
            'user' => $user,
            'form' => $form,
        ]);
    }

    /**
     * Require ROLE_ADMIN for this actions
     */
    #[IsGranted('ROLE_ADMIN')]
    #[Route('/{id}', name: 'app_user_delete', methods: ['POST'])]
    public function delete(Request $request, User $user, UserRepository $userRepository): Response
    {
        try {
            if ($this->isCsrfTokenValid('delete'.$user->getId(), $request->request->get('_token'))) {
                $userRepository->remove($user, true);
            }

            return $this->redirectToRoute('app_user_index', [], Response::HTTP_SEE_OTHER);

        } catch (\Throwable $th) {
            if($this->isGranted('ROLE_ADMIN')) {
                $this->addFlash('error', $th->getMessage());
            }
            else {
                $this->addFlash('error', ucfirst($this->translator->trans('alert admin')));
            }

            return $this->redirectToRoute('app_user_index', [], Response::HTTP_SEE_OTHER);
        }
    }

    /**
     * Require ROLE_ADMIN for this actions
     */
    #[IsGranted('ROLE_ADMIN')]
    #[Route('/{id}/change-password', name: 'app_user_change_passwd', methods: ['GET', 'POST'])]
    public function changePassword(Request $request, User $user, UserRepository $userRepository, EntityManagerInterface $entityManager, UserPasswordHasherInterface $userPasswordHasher): Response
    {
        $form = $this->createForm(ChangePasswordType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            try {
                $password = $form->get('password')->getData();
                $confirm_password = $form->get('confirm_password')->getData();

                /* Checking if the password and confirm password are the same. */
                if ($password !== $confirm_password) {
                    $this->addFlash('warning', 'Password are not equals.');
                    return $this->redirectToRoute('app_user_change_passwd', ['id' => $user->getId()], Response::HTTP_SEE_OTHER);
                }

                /* encode the plain password */
                $user->setPassword(
                    $userPasswordHasher->hashPassword(
                        $user,
                        $form->get('password')->getData()
                    )
                );

                $userRepository->add($user, true);

                $entityManager->persist($user);
                $entityManager->flush();

                $this->addFlash('notice', 'Password updated successfully.');

                return $this->redirectToRoute('app_user_index', [], Response::HTTP_SEE_OTHER);

            } catch (\Throwable $th) {
                if($this->isGranted('ROLE_ADMIN')) {
                    $this->addFlash('error', $th->getMessage());
                }
                else {
                    $this->addFlash('error', ucfirst($this->translator->trans('alert admin')));
                }
            }
        }

        return $this->render('user/change_passwd.html.twig', [
            'user' => $user,
            'form' => $form,
        ]);
    }
}
