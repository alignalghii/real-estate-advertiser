<?php

require 'Model.php';

class AdminController
{
	public function index()
	{
		$flats = Model::allFlatsWithPicsAmount();
		require 'view/admin.php';
	}
}
