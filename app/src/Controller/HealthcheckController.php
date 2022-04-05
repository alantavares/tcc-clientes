<?php

namespace App\Controller;

use DateTimeImmutable;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HealthcheckController  extends AbstractController
{
    /**
     * @return JsonResponse
     * @Route("/healthcheck", methods={"GET"}, name="healthcheck")
     */
    public function check(): Response
    {
        $now = new DateTimeImmutable();

        return new JsonResponse([
            'msg' => 'ok',
            'datetime' => $now->format('Y-m-d\TH:i:s\Z'),
            'timestamp' => $now->format('U'),
        ]);
    }
}