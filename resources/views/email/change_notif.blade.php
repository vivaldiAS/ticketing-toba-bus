<!DOCTYPE html>
<html>
<head>
    <title>Password Changed</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        h1 {
            color: #307475;
            margin-bottom: 20px;
        }

        p {
            margin-bottom: 10px;
        }

        .footer {
            margin-top: 20px;
            text-align: center;
            color: #777;
        }
    </style>
</head>
<body>
    <h1>Halo {{ $user->name }},</h1>

    <p>Password akun Anda telah berhasil diubah pada {{ $user->updated_at }}.</p>

    <p>Jika Anda tidak merasa melakukan perubahan ini, segera hubungi kami.</p>

    <p>Terima kasih.</p>

    <div class="footer">
        © {{ \Carbon\Carbon::now()->format('Y') }} e-KBT. All rights reserved.
    </div>
</body>
</html>
