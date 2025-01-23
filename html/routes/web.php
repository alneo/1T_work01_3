<?php
use App\Jobs\ProcessSendingEmail;
use App\Jobs\ProcessPodcast;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    ProcessSendingEmail::dispatch();
    ProcessPodcast::dispatch();
    return view('welcome');
});
