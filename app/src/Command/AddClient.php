<?php
namespace App\Command;

use \JsonSerializable;

class AddClient implements JsonSerializable
{
    private $id;
    private $name;
    private $email;
    private $phone;

    public function __construct(string $uuid, string $name, string $email, string $phone)
    {
        $this->id = $uuid;
        $this->name = $name;
        $this->email = $email;
        $this->phone = $phone;
    }

    public function getId(): string
    {
        return $this->id;
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function getEmail(): string
    {
        return $this->email;
    }

    public function getPhone(): string
    {
        return $this->phone;
    }

    public function jsonSerialize() {
        return [
            'id'=>$this->id, 
            'name'=>$this->name, 
            'email' => $this->email, 
            'phone'=>$this->phone
        ];
    }

}