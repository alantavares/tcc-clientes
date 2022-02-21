<?php

namespace App\Command\Handler;

use App\Command\AddClient;
use App\Entity\Client;
use App\Repository\ClientRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Messenger\Handler\MessageHandlerInterface;

#[AsMessageHandler]
class AddClientHandler implements MessageHandlerInterface
{
    private $clients;
    private $em;

    public function __construct(ClientRepository $clientRepository, EntityManagerInterface $em)
    {
        $this->clients = $clientRepository;
        $this->em = $em;
    }
    public function __invoke(AddClient $command)
    {

        $id = $command->getId();
        $name = $command->getName();
        $email = $command->getEmail();
        $phone = $command->getPhone();
        
        // if($this->clients->clientWithEmailExists($name)) {
        //     throw new \LogicException("Client with email has to be unique");
        // }

        $client = new Client($id, $name, $email, $phone);

        $this->em->persist($client);

        return $client;
        
    }
}