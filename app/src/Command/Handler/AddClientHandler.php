<?php

namespace App\Command\Handler;

use App\Command\AddClient;
use App\Entity\Client;
use App\Repository\ClientRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Messenger\Handler\MessageHandlerInterface;
use Symfony\Component\Messenger\MessageBusInterface;
use App\Domain\Event\ClientCreated;

#[AsMessageHandler]
class AddClientHandler implements MessageHandlerInterface
{
    private $clients;
    private $em;
    private $bus;

    public function __construct(ClientRepository $clientRepository, EntityManagerInterface $em, MessageBusInterface $messageBus)
    {
        $this->clients = $clientRepository;
        $this->em = $em;
        $this->bus = $messageBus;
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

        // $this->bus->dispatch( ClientCreated::createFromClient($client) );

        return $client;
        
    }
}