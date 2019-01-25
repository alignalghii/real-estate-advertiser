<?php

class Helper
{
	static function loadVar(string $pathFormat, string $broken, ?string &$fileName): string
	{
		return isset($fileName) ? sprintf($pathFormat, $fileName) : $broken;
	}
}
