<?php

// ck ment: This controller handles login, otp verification, and registration
namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use App\Services\OtpService;
use Carbon\Carbon;

class AuthController extends Controller
{
    protected $otpService;

    public function __construct(OtpService $otpService)
    {
        $this->otpService = $otpService;
    }

    // ck ment: Handle login request and send OTP
    public function requestOtp(Request $request)
    {
        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json(['status' => 'not_found'], 404);
        }

        $otp = $this->otpService->generateOtp();
        $user->otp = $otp;
        $user->otp_expires_at = Carbon::now()->addMinutes(90); //3 hours
        $user->save();

        $this->otpService->sendOtpEmail($user->email, $otp);

        return response()->json(['status' => 'otp_sent']);
    }

    // ck ment: Verify the entered OTP
    public function verifyOtp(Request $request)
    {
        $user = User::where('email', $request->email)->first();

        if ($user && $user->otp === $request->otp && Carbon::now()->lt($user->otp_expires_at)) {
            return response()->json(['status' => 'verified']);
        }

        return response()->json(['status' => 'invalid_otp'], 400);
    }

    // ck ment: Register a new user with phone number
    public function register(Request $request)
    {
        
        try {
            // ck ment: Validate the request for required fields and uniqueness
            $request->validate([
                'email' => 'required|email|unique:users',
                'phone' => 'required'
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            // ck ment: Return a structured JSON response if validation fails
            return response()->json([
                'status' => 'validation_error',
                'message' => 'Validation failed',
                'errors' => $e->errors() // ck ment: Includes field-specific messages like 'email has already been taken'
            ], 422);
        }

        User::create([
            'email' => $request->email,
            'phone' => $request->phone,
            'password'=> rand(10000, 100000)
        ]);


        //send OTP
        $this->requestOtp($request);

        return response()->json(['status' => 'registered and OTP sent, please check your email']);
    }
}
