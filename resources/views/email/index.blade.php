<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Password Reset OTP</title>
    <style>
        /* Add your custom styles here */
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th,
        td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
        }

        .logo {
            width: 100px;
            /* Adjust the width as needed */
        }

        .otp-code {
            font-size: 25px;
            font-weight: bold;
            text-align: center
        }
        .logo{
            align-items: center;
        }
    </style>
</head>

<body>
    <!-- Add your application's logo -->
    <div class="logo">
        <img src="https://eticketingkbt.online/images/logo-KBT.png" alt="Logo" class="logo">
    </div>

    <h1>Hello {{ $user->name }},</h1>
    <p>Kami telah menerima permintaan untuk mengatur ulang kata sandi Anda.</p>
    <p>
        Jika Anda tidak memulai permintaan ini, harap abaikan email ini.</p>

    <h2>Your Password Reset One-Time Password (OTP):</h2>
    <table>
        <tr>
            <th>Date</th>
            <th>Username</th>
        </tr>
        <tr>
            <td>{{ \Carbon\Carbon::now()->format('Y-m-d H:i:s') }}</td>
            <td>{{ $user->name }}</td>
        </tr>
    </table>

    <p class="otp-code">{{ $user->remember_token }}</p>

    <p>OTP berlaku untuk sekali pakai dan akan kedaluwarsa setelah beberapa saat.</p>
    <p>Jika Anda telah memulai permintaan ini, silakan masukkan OTP di halaman atur ulang kata sandi.</p>

    <p class="mt-3"> Terima kasih.</p>
    <h3>Team e-KBT</h3>
</body>

</html>
