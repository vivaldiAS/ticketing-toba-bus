<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <meta name="csrf-token" content="{{ csrf_token() }}">

  <title>e-KBT </title>

  <!-- Favicon -->
  {{-- <link rel="shortcut icon" href="{{ asset('favicon.ico') }}"> --}}
  <link rel="preconnect" href="https://fonts.gstatic.com" />

  <!-- Font -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

  <script src="{{ asset(mix('js/app.js')) }}" defer></script>
  {{-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_lX5Kf_oGH_rBt6gj-e4zH_-Xb90Qk7M"></script> --}}
  <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_lX5Kf_oGH_rBt6gj-e4zH_-Xb90Qk7M&callback=initMap&v=weekly"
      defer
    ></script>
</head>

<body>
  <div id="app">
  </div>
</body>

</html>
