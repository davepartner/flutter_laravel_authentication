<?php

// ck ment: This service handles generating and sending OTP using SendPulse
namespace App\Services;

use Sendpulse\RestApi\ApiClient;
use Sendpulse\RestApi\Storage\FileStorage;
use Carbon\Carbon;
use App\Models\User;

class OtpService
{
    protected $sendpulse;

    public function __construct()
    {
        // Initialize SendPulse
        $this->sendpulse = new ApiClient(
            env('SENDPULSE_USER_ID'),
            env('SENDPULSE_SECRET'),
            new FileStorage()
        );
    }

    // ck ment: Generate a 6-digit OTP
    public function generateOtp()
    {
        return rand(100000, 999999);
    }

    // ck ment: Send the OTP to user via email
    public function sendOtpEmail($email, $otp)
    {
        $emailData = [
            'html' => "<p>Your OTP is: <strong>$otp</strong></p>",
            'text' => "Your OTP is: $otp",
            'subject' => 'Your Login OTP',
            'from' => [
                'name' => env('SENDPULSE_FROM_NAME'),
                'email' => env('SENDPULSE_SENDER_EMAIL'),
            ],
            'to' => [
                [
                    'name' => '',
                    'email' => $email,
                ],
            ],
        ];

        return $this->sendpulse->smtpSendMail($emailData);
    }
}