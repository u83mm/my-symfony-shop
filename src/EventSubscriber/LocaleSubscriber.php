<?php

namespace App\EventSubscriber;

use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpKernel\Event\RequestEvent;
use Symfony\Component\HttpKernel\KernelEvents;

class LocaleSubscriber implements EventSubscriberInterface
{
    public function __construct(private string $defaultLocale = 'es')
    {
        
    }

    public function onkernelRequest(RequestEvent $event): void 
    {
        $request = $event->getRequest();

        // Set the locale based on the session or default to the configured locale
        if(!$request->hasPreviousSession() || !$request->getSession()->has('_locale')) {
            $request->setLocale($this->defaultLocale);
        }
        else {
            $request->setLocale($request->getSession()->get('_locale'));
        }
    }

    public function onRequestEvent(RequestEvent $event): void
    {
        // ...
    }

    public static function getSubscribedEvents(): array
    {
        /* return [
            RequestEvent::class => 'onRequestEvent',
        ]; */

        return [
            KernelEvents::REQUEST => [
                ['onKernelRequest', 20],
            ]
        ];
    }
}
