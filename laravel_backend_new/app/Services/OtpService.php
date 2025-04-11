<?php

// ck ment: This service handles generating and sending OTP emails using SendPulse's SMTP API

namespace App\Services;

use Sendpulse\RestApi\ApiClient;          // Import SendPulse API client
use Sendpulse\RestApi\Storage\FileStorage; // For storing access tokens
use Carbon\Carbon;                        // (Optional) for timestamping
use App\Models\User;                      // Your user model

class OtpService
{
    protected $sendpulse; // Holds the SendPulse API client instance

    // ck ment: Constructor initializes SendPulse API client with credentials
    public function __construct()
    {
        // Create the SendPulse API client using credentials from .env file
        $this->sendpulse = new ApiClient(
            env('SENDPULSE_USER_ID'),    // Your API user ID
            env('SENDPULSE_SECRET'),     // Your API secret
            new FileStorage()            // Storage class to cache tokens
        );
    }

    // ck ment: Generate a random 6-digit OTP for user login or verification
    public function generateOtp()
    {
        return rand(100000, 999999); // Generates a number like 482391
    }

    // ck ment: Sends the OTP to a user's email address using SendPulse SMTP
    public function sendOtpEmail($email, $otp)
    {
        // Compose the email structure required by SendPulse SMTP API
        $emailData = [
            'html' => "<p>Your OTP is: <strong>$otp</strong></p>", // Email body (HTML)
            'text' => "Your OTP is: $otp",                          // Fallback plain text
            'subject' => 'Your Login OTP',                          // Email subject
            'from' => [
                'name' => env('SENDPULSE_FROM_NAME'),               // Sender name (e.g., "MyApp")
                'email' => env('SENDPULSE_SENDER_EMAIL'),           // Sender email (must be verified in SendPulse)
            ],
            'to' => [
                [
                    'name' => '',                                    // Recipient name (optional)
                    'email' => $email,                               // Recipient email
                ],
            ],
        ];

        // Send the email using SendPulse's SMTP API
        return $this->sendpulse->smtpSendMail($emailData);
    }
}
