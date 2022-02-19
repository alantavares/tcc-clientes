<?php

namespace App\Controller;

// use Ramsey\Uuid\Uuid;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Messenger\MessageBusInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Messenger\Stamp\HandledStamp;

use App\Command\AddClient;
use App\Query\GetSomething;
// use App\Entity\Client;

class ClientController extends AbstractController
{
    use HandleTrait;

    public function __construct(MessageBusInterface $messageBus)
    {
        $this->messageBus = $messageBus;
    }

    /**
     * @return JsonResponse
     * @Route("/clients", methods={"POST"})
     */
    public function add(Request $request, MessageBusInterface $messageBus)
    {
        $name = $request->get('name');
        $email = $request->get('email');
        $phone = $request->get('phone');        
        $addClient = new AddClient($name, $email, $phone);

        try {
            $envelope = $messageBus->dispatch($addClient);
            $handledStamp = $envelope->last(HandledStamp::class);
            $client = $handledStamp->getResult();
            
        } catch (\Exception $e) {
            //TODO Handle exception
            dd($e->getMessage());
        }
        return $this->response($client,201);
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

    // Creating such a method is optional, but allows type-hinting the result
    private function query(Client $query): Client
    {
        return $this->handle($query);
    }

}