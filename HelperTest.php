<?php

use PHPUnit\Framework\TestCase;

require 'Helper.php';

class HelperTest extends TestCase
{
	public function testCanLoadPathVariableSafelyFromExistingMap(): void
	{
		$map = ['image' => 'kitchen.jpg'];
		$actual = \Helper::loadVar('3/%s', '-NONE-', $map['image']);
		$this->assertEquals('3/kitchen.jpg', $actual);
	}

	public function testCanLoadPathVariableSafelyFromNonexistingMap(): void
	{
		$map = ['image' => 'kitchen.jpg'];
		$actual = Helper::loadVar('3/%s', '-NONE-', $map['imagex']);
		$this->assertEquals('-NONE-', $actual);
	}
}
