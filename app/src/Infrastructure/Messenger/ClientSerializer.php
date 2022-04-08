<?php

namespace App\Infrastructure\Messenger;

use App\Domain\Event\ClientCreated;
use Symfony\Component\Messenger\Envelope;
use Symfony\Component\Messenger\Transport\Serialization\SerializerInterface;

final class ClientSerializer implements SerializerInterface
{
    public function decode(array $encodedEnvelope): Envelope
    {
        $record = json_decode($encodedEnvelope['body'], true);

        return new Envelope(new ClientCreated(
            $record['id'],
            $record['name'],
            $record['email'],
            $record['phone'],
        ));
    }

    public function encode(Envelope $envelope): array
    {
        /** @var ClientCreated $event */
        $event = $envelope->getMessage();
        
        return [
            'key' => $event->getId(),
            'headers' => [],
            'body' => json_encode([
                'id' => $event->getId(),
                'name' => $event->getName(),
                'email' => $event->getEmail(),
                'phone' => $event->getPhone()
            ]),
        ];
    }

}