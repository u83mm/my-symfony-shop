<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Contracts\Translation\TranslatorInterface;

final class LocalController extends AbstractController
{
    private array $supportedLocales = ['en', 'es'];

    public function __construct(private TranslatorInterface $translator)
    {
        
    }
    
    #[Route('/change-locale/{locale}', name: 'app_change_locale')]
    public function change(string $locale, Request $request): Response
    {
        try {
            // Validate the requested locale
            if (!in_array($locale, $this->supportedLocales)) {
                $locale = $this->getParameter('kernel.default_locale');
            }

            $request->getSession()->set('_locale', $locale);

            $referer = $request->headers->get('referer');

            if ($referer) {
                $refererPath = parse_url($referer, PHP_URL_PATH);

                // Check if the referer already has a locale prefix
                $hasLocale = false;
                foreach ($this->supportedLocales as $supportedLocale) {
                    if (str_starts_with($refererPath, "/$supportedLocale/") || 
                        $refererPath === "/$supportedLocale") {
                        $hasLocale = true;
                        break;
                    }
                }

                if ($hasLocale) {
                    // Replace the locale in the referer URL
                    $newReferer = preg_replace(
                        '~^/([a-z]{2})(/|$)~', 
                        "/$locale$2", 
                        $refererPath
                    );
                    return $this->redirect($newReferer);
                }
                
            }

            return $this->redirectToRoute('app_home', ['_locale' => $locale]);

        } catch (\Throwable $th) {
            if($this->isGranted('ROLE_ADMIN')) {
                $this->addFlash('error', $th->getMessage());                
            }
            else {
                $this->addFlash('error', ucfirst($this->translator->trans('admin alert')));
            }

            return $this->redirectToRoute('app_home', ['_locale' => $locale]);
        }
    }
}
