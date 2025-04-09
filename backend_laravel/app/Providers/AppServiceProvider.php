<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Route;
class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
        

     Route::group([], base_path('routes/api.php')); // Add your custom file
    }
}
