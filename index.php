<?php
echo '<!DOCTYPE html>
<html>
   <head>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <style>
         #solar-system {
            background: url("https://raw.githubusercontent.com/vidalgithub/solar-system-9/feature/images/solar-system-3.png") center center;
            background-repeat: no-repeat;
            background-size: cover;
            content: "";
            position: static;
            animation: spin 25s linear infinite;
            width: 50vw;
            height: 50vw;
         }

         @keyframes spin {
            100% {
               transform: rotate(360deg);
            }
         }

         body {
            display: flex;
            align-items: center;
            justify-content: center;
            background: url("https://raw.githubusercontent.com/vidalgithub/solar-system-9/feature/images/background.png");
            background-size: cover;
            height: 100vh;
            margin: 0;
         }
      </style>
   </head>
   <body>
      <div id="solar-system"> </div>
   </body>
</html>';
?>
