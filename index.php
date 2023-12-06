<?php
echo '<!DOCTYPE html>
<html>
   <head>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <style>
         #solar-system {
            background: url("https://github.com/vidalgithub/solar-system-9/blob/feature/images/animated-solar-system.png") center center;
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
            background: url("https://github.com/vidalgithub/solar-system-9/blob/feature/images/background.gif");
            /* Additional styles can be added here */
         }
      </style>
   </head>
   <body>
      <div id="solar-system"></div>
   </body>
</html>';
?>
