<?php

class ErrorController
{
	private $message;

	public function __construct(string $message) {$this->message = $message;}

	public function index() {}
}
