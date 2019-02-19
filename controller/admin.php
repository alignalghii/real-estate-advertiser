<?php

require 'Model.php';

class AdminController
{
	public function index()
	{
		$flats = Model::allFlats();
		require 'view/admin.php';
	}
}
