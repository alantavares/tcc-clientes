<?php

declare(strict_types=1);

namespace App\Infrastructure\Consumer;

use Symfony\Component\Messenger\Handler\MessageHandlerInterface;
use App\Domain\Event\ClientCreated;

#[AsMessageHandler]
class ClientCreatedHandler implements MessageHandlerInterface
{
    
    public function __invoke(ClientCreated $event) : void
    {        
        echo "OI OI OI " . $event->getId();
    }
}