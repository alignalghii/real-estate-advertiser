<?php

class ErrorController
{
	private $message;

	public function __construct(string $message) {$this->message = $message;}

	public function index()
	{
		$errorMsg = $this->message;
		require 'view/error.php';
	}
}
