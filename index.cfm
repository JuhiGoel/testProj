<html>

	<head>

		<title>CFML Login</title>
		<link rel="stylesheet" type="text/css" href="styles/bootstrap.min.css"/>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.5.3/css/bootstrapValidator.css">
		<link rel="stylesheet" type="text/css" href="styles/home.css"/>
		<script language="javascript" src="scripts/jquery.js"></script>
		<script language="javascript" src="scripts/bootstrap.min.js"></script>
		<script language="javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.5.3/js/bootstrapValidator.min.js"></script>
		<script language="javascript" src="scripts/home.js"></script>

	</head>
	<body>

		<div class="container">

			<div class = "form-box">
			
				<ul class="nav nav-pills">							
					<li id="tab_register" class="active"><a>Register</a></li>
					<li id="tab_login"><a>Login</a></li>						
				</ul>
				<div class="wrapper">
					
					<form class="form-horizontal" method="post" action="#" id="form_register">
									
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="first_name" id="first_name"  placeholder="First Name*"/>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="last_name" id="last_name"  placeholder="Last Name"/>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-mobile" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="phone_number" id="phone_number"  placeholder="Phone Number"/>
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="email_id" id="email_id"  placeholder="Email Id*"/>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-eye" aria-hidden="true"></i></span>
									<input type="password" class="form-control" name="password" id="password"  placeholder="Password*"/>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-eye" aria-hidden="true"></i></span>
									<input type="password" class="form-control" name="confirm_password" id="confirm_password"  placeholder="Confirm Password*"/>
								</div>
							</div>
						</div>

						<div class="form-group ">
							<button id="btn_register" class="btn btn-primary btn-lg btn-block submit-btn">
								Register
							</button>
						</div>
								
					</form>
					<form class="form-horizontal hide" method="post" action="#" id="form_login">

						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="email_id" id="user_email"  placeholder="Email Id*"/>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-eye" aria-hidden="true"></i></span>
									<input type="password" class="form-control" name="password" id="login_password"  placeholder="Password"/>
								</div>
							</div>
						</div>

						<div class="form-group ">
							<button id="btn_login" class="btn btn-primary btn-lg btn-block submit-btn">
								Login
							</button>
						</div>
								
					</form>
				</div>
			</div>
		</div>
	</body>
</html>