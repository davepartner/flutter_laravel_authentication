<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/
// routes/web.php

use App\Services\OtpService;

Route::get('/test-otp', function (OtpService $otpService) {
    $otp = $otpService->generateOtp();
    $response = $otpService->sendOtpEmail('your@email.com', $otp);
    return $response;
});

Route::get('/', function () {
    return view('welcome');
});
