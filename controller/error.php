<?php

require 'Icon.php';

class ErrorController
{
	private $message;

	public function __construct(string $message) {$this->message = $message;}

	public function index()
	{
		$errorMsg  = $this->message;
		$backlinks = ['⚙ Kezelői felület' => '?p=admin', Icon::USER.' Felhasználói felület' => '?p=overview'];
		require 'view/error.php';
	}
}
