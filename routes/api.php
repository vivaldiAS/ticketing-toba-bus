<?php

use App\Http\Controllers\AdminLoketController;
use App\Http\Controllers\BookingController;
use App\Http\Controllers\BusController;
use App\Http\Controllers\ConfirmPembayaran;
use App\Http\Controllers\DashboardDireksiController;
use App\Http\Controllers\DireksiController;
use App\Http\Controllers\DokuController;
use App\Http\Controllers\KeuanganController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\LoketController;
use App\Http\Controllers\LupaPasswordController;
use App\Http\Controllers\PASTIController;
use App\Http\Controllers\PembayaranController;
use App\Http\Controllers\RegisterUserController;
use App\Http\Controllers\RoutesController;
use App\Http\Controllers\ScheduleController;
use App\Http\Controllers\SupirController;
use App\Http\Controllers\TicketController;
use App\Http\Controllers\UpdateStatusUserController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\DokuPaymentController;
use App\Http\Controllers\PaymentsController;
use App\Http\Controllers\DefaultSchedulesController;
use App\Http\Controllers\KomisiController;



use App\Models\Bookings;
use App\Models\bus;
use App\Models\Role;
use App\Utils\SignatureDoku;
use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
// Route::get('signature', function () {
//     // return $request;
//     $signature = SignatureDoku::generateToken();

//     return $signature;
// });


// Route::post('/pembayaran', [PembayaranController::class, 'generateToken']);
Route::post('login', [LoginController::class, 'login']);

Route::put('/buses/{id}', [PASTIController::class, 'update']);
Route::delete('/buses/{id}', [PASTIController::class, 'destroy']);
Route::get('/routes/all', [PASTIController::class, 'lihatRoutes']);
Route::post('/routes/tambah', [PASTIController::class, 'storeRoutes']);
Route::put('/routes/update/{id}', [RoutesController::class, 'update']);
Route::delete('/routes/destroy/{id}', [RoutesController::class, 'destroy']);

Route::domain('/doku-payment')->group(function () {
    Route::get('/', [DokuPaymentController::class, 'checkoutPayment']);        
});

Route::post('/payments/notifications', [DokuController::class, 'notifications']);

Route::post('registrasi', [RegisterUserController::class, 'RegisterUser']);
Route::post('reset-password', [LupaPasswordController::class, 'sendOTP']);
Route::post('getOtp', [LupaPasswordController::class, 'getOtp']);
Route::post('reset/update-password/{email}', [LupaPasswordController::class, 'resetPassword']);

Route::get('/schedule/show/all', [ScheduleController::class, 'index']);
Route::put('user/update/{id}', [UserController::class, 'update']);
Route::put('status/update/auto/{id}', [ScheduleController::class, 'UpdateStatusAuto']);

Route::middleware(['auth:api', 'role: admin_kantor,direksi'])->group(function () {
Route::put('/account/update/status/{id}', [UpdateStatusUserController::class, 'update']);
});


Route::middleware(['auth:api', 'role:admin_loket,admin_kantor,driver,passenger,direksi'])->group(function () {
    Route::post('logout', [LoginController::class, 'logout']);
    Route::get('/bookings/my', [BookingController::class, 'getByUserId']);

    Route::post('user/update-password', [UserController::class, 'updatePassword']);
    Route::get('/user/profile', [UserController::class, 'user']);
    Route::get('payments/{paymentId}', [PaymentsController::class, 'getPaymentById']);
    Route::get('/routes', [RoutesController::class, 'getAllRoutes']);
    Route::get('user/get/{id}', [UserController::class, 'getUser']);
});

Route::put('/konfirmasiberhasiltunai', [BookingController::class, 'confirmBooking']);
Route::put('/batalkanbooking', [BookingController::class, 'cancelBooking']);


Route::middleware(['auth:api', 'role:admin_loket,admin_kantor,driver,passenger'])->group(function () {
    Route::get('/routes/show/all', [RoutesController::class, 'showRoutesByAdminId']);
    Route::get('/route-bus/show/all', [RoutesController::class, 'showRoutesBusByAdminId']);
    
    Route::get('/schedule/show/{id}', [ScheduleController::class, 'SelectOne']);
    Route::get('/schedule/bayartunai/{id}', [ScheduleController::class, 'SelectOnes']);

    Route::get('/schedule/type/executive', [ScheduleController::class, 'ShowExecutive']);
    Route::get('/schedule/type/economi', [ScheduleController::class, 'ShowEconomi']);
    Route::post('bookings', [BookingController::class, 'store']);
    Route::post('bookings/nontunai', [PembayaranController::class, 'generateToken']);
    Route::get('/bookings/show/schedules/{id}', [BookingController::class, 'getOneSchedules']);
    Route::get('/bookings/show/waiting/schedules/{id}', [BookingController::class, 'WaitPayment']);
    Route::get('/bookings/show/{id}', [BookingController::class, 'getOne']);
    Route::get('/pesanan/ticket/{id}', [TicketController::class, 'index']);
    Route::post('bookings/bayartunai', [BookingController::class, 'bookingBayarTunai']);
    Route::post('bookings/bayarmt', [BookingController::class, 'bookingMidtrans']);
});




Route::middleware(['auth:api', 'role:admin_loket,direksi'])->group(function () {
    Route::get('/Keuangan/index', [KeuanganController::class, 'index']);

    Route::get('/Detail-keuangan-Bydate/{tanggal}', [KeuanganController::class, 'getByTanggal']);
    Route::get('/Detail-keuangan-ByPassenger/{id}', [KeuanganController::class, 'getPassenger']);
    Route::get('/bookings/index/all', [BookingController::class, 'index']);
    Route::put('/bookings/update/{id}', [BookingController::class, 'update']);
    Route::get('/schedule/show/admin/all', [ScheduleController::class, 'showForAdmin']);
    Route::get('/konfirmasi-booking-tunai', [BookingController::class, 'showBokingTunaiOnline']);
    Route::get('/lokets-by-admin', [LoketController::class, 'getLoketsByAdmin']);
});
Route::get('/pesanan-online/{id}', [BookingController::class, 'PesananOnlineBySchedulesID']);

Route::middleware(['auth:api', 'role:passenger'])->group(function () {
    Route::get('/riwayat/my', [BookingController::class, 'getriwayat']);
    Route::put('/bookings/update-status/{id}', [BookingController::class, 'expiredCheck']);
});


Route::middleware(['auth:api', 'role:admin_kantor'])->group(function () {
    Route::delete('/deleteSchedule/{id}', [ScheduleController::class, 'deleteschedule']);

    Route::post('/DefaultSchedulesToSchedules', [DireksiController::class, 'DefaultSchedulesToSchedules']);

    Route::get('/Detail-keuangan-ByPassenger/all/{id}', [DireksiController::class, 'getPassenger']);
    Route::get('/Detail-keuangan-Bydate/all/{tanggal}', [DireksiController::class, 'getByTanggal']);

    Route::get('/lokasi-loket', [RoutesController::class, 'getLokasiLoket']);
    Route::post('/DefaultSchedulesToSchedules', [DireksiController::class, 'DefaultSchedulesToSchedules']);
    Route::post('/schedule/add', [ScheduleController::class, 'store']);
    Route::put('/default-schedules/edit/{id}', [DefaultSchedulesController::class, 'editDefaultSchedules']);
    Route::post('/default-schedules/add', [defaultSchedulesController::class, 'addDefaultSchedules']);
    Route::get('/default-schedules', [DefaultSchedulesController::class, 'getDefaultSchedules']);
    Route::get('/default-schedules/{id}', [DefaultSchedulesController::class, 'getDefaultScheduleById']);

    Route::get('/Dashboard/direksi', [DashboardDireksiController::class, 'CountAll']);
    Route::post('/buses/store', [PASTIController::class, 'storeBus']);
    Route::get('/Keuangan/all/index', [DireksiController::class, 'index']);

    Route::put('/bus/update/status/{id}', [BusController::class, 'updateStatus']);

    Route::get('bus/get/{id}', [BusController::class, 'SelectOneBus']);

    Route::post('/registrasi/supir', [RegisterUserController::class, 'RegistrasiSupir']);
    Route::get('/supir/all', [SupirController::class, 'index']);
    Route::get('/supir/name/all', [SupirController::class, 'getOne']);

    Route::post('/registrasi/adminLoket', [AdminLoketController::class, 'store']);
    Route::get('/admin-loket/all', [AdminLoketController::class, 'index']);
    Route::post('/loket/add', [LoketController::class, 'store']);
    Route::get('/loket/all', [LoketController::class, 'show']);
    Route::get('/admin-loket/all/notAssociated', [LoketController::class, 'notAssociated']);

    Route::put('/update/status/loket/{id}', [LoketController::class, 'UpdateStatus']);
    Route::get('/loket/get/{id}', [LoketController::class, 'getOne']);
    Route::put('/loket/update/{id}', [LoketController::class, 'update']);

    Route::post('/buss/add', [BusController::class, 'store']);
    Route::get('/buss/show/all', [BusController::class, 'show']);
    Route::get('/buss/show/notAssociated', [BusController::class, 'notAssociated']);
    Route::get('/buss/show/noJadwal', [BusController::class, 'busnoJadwal']);
    Route::put('/buss/update/{id}', [BusController::class, 'update']);
    Route::delete('/buss/delete/{id}', [BusController::class, 'delete']);

    Route::post('/routes/add', [RoutesController::class, 'store']);
    Route::put('/routes/update/status/{id}', [RoutesController::class, 'UpdateStatusRoute']);
    Route::get('/routes/get/{id}', [RoutesController::class, 'getOneRoute']);
    Route::get('/brandsyanglogin', [DireksiController::class, 'brandsyanglogin']);

    Route::get('/schedule/admin/show/all', [ScheduleController::class, 'ShowAll']);
});

Route::middleware(['auth:api', 'role:driver'])->group(function () {
    Route::get('/schedules/driver', [ScheduleController::class, 'getForSupir']);
    Route::get('/confirmasi-pembayaran', [ConfirmPembayaran::class, 'index']);
    Route::put('/update-status/{id}', [ScheduleController::class, 'UpdateStatusBus']);
});

Route::get('/user/all', [DireksiController::class, 'userAll']);

Route::middleware(['auth:api', 'role:direksi'])->group(function () {
    Route::get('/statistik/direksi', [DireksiController::class, 'CountAdminKantor']);
    Route::get('/GetAdminKantor', [DireksiController::class, 'getadminkantor']);
    Route::get('/GetAdminKantor/notAssociated', [DireksiController::class, 'adminkantorNotAssociated']);
    Route::post('/registrasi/adminkantor', [RegisterUserController::class, 'RegistrasiAdminKantor']);
    Route::post('/registrasi/brands', [RegisterUserController::class, 'RegistrasiBrand']);
    Route::put('/udpate-brands/{id}', [DireksiController::class, 'updatebrands']);
    Route::get('/brands/{id}', [DireksiController::class, 'getBrandsById']);
    Route::put('/update/status-brands/{id}', [DireksiController::class, 'updateBrandsStatus']);
});


Route::middleware(['auth:api', 'role:admin_kantor'])->group(function () {
    Route::get('/komisi/{id}', [KomisiController::class, 'index']);
    Route::get('/komisi', [KomisiController::class, 'index2']);
    Route::put('/komisi', [KomisiController::class, 'updateKomisi']);
});




Route::post('/payment/callback', [BookingController::class, 'callback']);


// PA 2
Route::get('/allBrands', [DireksiController::class, 'getAllBrands']);
Route::get('/busbrand/{id}', [BusController::class, 'getBusByBrandsId']);
Route::get('/busss/show/all', [BusController::class, 'show2']);

