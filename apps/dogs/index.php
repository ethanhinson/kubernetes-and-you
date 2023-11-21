<?php
$dogApiUrl = "https://dog.ceo/api/breeds/image/random";
$jsonData = file_get_contents($dogApiUrl);
$data = json_decode($jsonData, true);
$imageUrl = $data['message'];
echo "<img src='$imageUrl' alt='Random Dog Image'>";
