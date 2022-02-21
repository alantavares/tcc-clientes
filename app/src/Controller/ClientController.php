<?php

namespace App\Controller;

use Ramsey\Uuid\Uuid;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Messenger\MessageBusInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;

use App\Command\AddClient;
// use App\Entity\Client;

class ClientController extends AbstractController
{

    /**
     * @return JsonResponse
     * @Route("/clients", methods={"POST"})
     */
    public function add(Request $request, MessageBusInterface $messageBus)
    {
        $id = Uuid::uuid4()->serialize();
        $name = $request->get('name');
        $email = $request->get('email');
        $phone = $request->get('phone');        
        $addClient = new AddClient($id, $name, $email, $phone);

        try {
            $messageBus->dispatch($addClient);                        
        } catch (\Exception $e) {
            //TODO Handle exception
            dd($e->getMessage());
        }
        return $this->response($addClient,201);
    }

    /**
     * Returns a JSON response
     *
     * @param array $data
     * @param $status
     * @param array $headers
     * @return JsonResponse
     */
    public function response($data, $status = 200, $headers = [])
    {
        return new JsonResponse($data, $status, $headers);
    }

}