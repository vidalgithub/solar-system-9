<?php 
echo '<!DOCTYPE html>
<html>
   <head>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <style>
		#solar-system {
		   background: url("https://github.com/vidalgithub/solar-system-9/tree/main/images/solar-system-3.png")   center center;
           background-repeat: no-repeat;			  
		   background-size: cover;
		   content: "";
		   position: static;
		   animation: spin 25s linear infinite;
		   width: 50vw;
		   height: 50vw;
		}

		@keyframes spin {
		  100% { transform: rotate(360deg); }
		}
		
		body {
			display: flex;
			align-items: center;
			justify-content: center;
			background: url("https://github.com/vidalgithub/solar-system-9/tree/main/images/background.png");
		}
		
/* 		.shadow {
			  animation: rainbow 2s linear infinite;
			} */


      </style>
   </head>
   <body>
	   
				 <div id="solar-system"> </div>

   </body>
</html>
';
