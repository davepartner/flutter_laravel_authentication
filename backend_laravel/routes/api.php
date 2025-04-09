<?php
use Illuminate\Support\Facades\Route;

Route::post('/login', [App\Http\Controllers\AuthController::class, 'requestOtp']);
Route::post('/verify', [App\Http\Controllers\AuthController::class, 'verifyOtp']);
Route::post('/register', [App\Http\Controllers\AuthController::class, 'register']);
