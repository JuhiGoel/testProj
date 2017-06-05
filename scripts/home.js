
function showAlert(type, message){
	var alert = $('<div class="alert alert-dismissable fade in"><a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');
	alert.addClass('alert-'+ type);
	alert.append(message);
	$('body').prepend(alert);
	setTimeout(function(){alert.remove();},3000);
}

function showHomePage(name){
	var name = name ||'';
	var home =  $('<div class="home-header"></div>');
	home.append('<span id="logout"><i class="fa fa-sign-out"></i>Logout</span><h1 class="greet">Hello! ' + name +'</h1>');
	$('.container').html(home[0]);
	
	return;

}

function validate(id){	
	$('.'+id).bootstrapValidator({
		feedbackIcons: {
			valid: 'fa fa-check',
			invalid: 'fa fa-close',
			validating: 'fa fa-refresh'
		},
		fields: {
			first_name: {
				validators: {
					notEmpty: {
						message: 'Please supply your first name'
					},
					stringLength: {
						min: 2,
					},
					regexp: {
						regexp: /^[a-zA-Z'.]+$/,
						message: 'First name can have only upper or lower case characters'
					}
				}
			},
			last_name: {
				validators: {
					
					notEmpty: {
						message: 'Please supply your last name'
					},
					stringLength: {
						min: 2,
					}
					
				}
			},
			email_id: {
				validators: {
					notEmpty: {
						message: 'Please supply your email address'
					},
					emailAddress: {
						message: 'Please supply a valid email address'
					}
				}
			},
			phone_number: {
				validators: {
				
					notEmpty: {
							message: 'Please supply your phone number'
					},
					regexp: {
						regexp: /^(((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4})|\d{10}$/,
						message: 'Please supply a valid phone number'
					}
				}
			},
			password: {
				validators: {
					notEmpty: {
						message: 'Please supply a password'
					}
				}
			},
			confirm_password: {
				validators: {
					notEmpty: {
						message: 'Please supply a password'
					},
					identical: {
						field: 'password',
						message: 'The password and its confirm are not the same'
					}
				}
			}
		}
	});

}

function showForm(){
	debugger;
	var form =  createForm();
	$('.container').html(form);
	validate('form-horizontal');

	return;
}
function createForm(){
	var form = '<div class = "form-box">' +
			'				<ul class="nav nav-pills">'+
			'					<li id="tab_register" class="active"><a>Register</a></li>' +
			'					<li id="tab_login"><a>Login</a></li>' +
			'				</ul>' +
			'				<div class="wrapper">' +
			'					<form class="form-horizontal" method="post" action="#" id="form_register">' +
			'						<div class="form-group">' +
			'							<div class="cols-sm-10">' +
			'								<div class="input-group">' +
			'									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>' +
			'									<input type="text" class="form-control" name="first_name" id="first_name"  placeholder="First Name*"/>' +
			'								</div>' +
			'							</div>' +
			'						</div>' +
			'						<div class="form-group">' +
			'							<div class="cols-sm-10">' +
			'								<div class="input-group">' +
			'									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>' +
			'									<input type="text" class="form-control" name="last_name" id="last_name"  placeholder="Last Name"/>' +
			'								</div>' +
			'							</div>' +
			'						</div>' +
			'						<div class="form-group">' +
			'							<div class="cols-sm-10">' +
			'								<div class="input-group">' +
			'									<span class="input-group-addon"><i class="fa fa-mobile" aria-hidden="true"></i></span>' +
			'									<input type="text" class="form-control" name="phone_number" id="phone_number"  placeholder="Phone Number"/>' +
			'								</div>' +
			'							</div>' +
			'						</div>' +
			'						<div class="form-group">' +
			'							<div class="cols-sm-10">' +
			'								<div class="input-group">' +
			'									<span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>' +
			'									<input type="text" class="form-control" name="email_id" id="email_id"  placeholder="Email Id*"/>' +
			'								</div>' +
			'							</div>' +
			'						</div>' +
			'						<div class="form-group">' +
			'							<div class="cols-sm-10">' +
			'								<div class="input-group">' +
			'									<span class="input-group-addon"><i class="fa fa-eye" aria-hidden="true"></i></span>' +
			'									<input type="password" class="form-control" name="password" id="password"  placeholder="Password*"/>' +
			'								</div>' +
			'							</div>' +
			'						</div>' +
			'						<div class="form-group">' +
			'							<div class="cols-sm-10">' +
			'								<div class="input-group">' +
			'									<span class="input-group-addon"><i class="fa fa-eye" aria-hidden="true"></i></span>' +
			'									<input type="password" class="form-control" name="confirm_password" id="confirm_password"  placeholder="Confirm Password*"/>' +
			'								</div>' +
			'							</div>' +
			'						</div>' +
			'						<div class="form-group ">' +
			'							<button id="btn_register" class="btn btn-primary btn-lg btn-block submit-btn">' +
			'								Register' +
			'							</button>' +
			'						</div>' +
			'								' +
			'					</form>' +
			'					<form class="form-horizontal hide" method="post" action="#" id="form_login">' +
			'						<div class="form-group">' +
			'							<div class="cols-sm-10">' +
			'								<div class="input-group">' +
			'									<span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>' +
			'									<input type="text" class="form-control" name="email_id" id="user_email"  placeholder="Email Id*"/>' +
			'								</div>' +
			'							</div>' +
			'						</div>' +
			'						<div class="form-group">' +
			'							<div class="cols-sm-10">' +
			'								<div class="input-group">' +
			'									<span class="input-group-addon"><i class="fa fa-eye" aria-hidden="true"></i></span>' +
			'									<input type="password" class="form-control" name="password" id="login_password"  placeholder="Password"/>' +
			'								</div>' +
			'							</div>' +
			'						</div>' +
			'						<div class="form-group ">' +
			'							<button id="btn_login" class="btn btn-primary btn-lg btn-block submit-btn">' +
			'								Login' +
			'							</button>' +
			'						</div>' +
			'					</form>' +
			'				</div>' +
			'			</div>';
	return form;
}

$(document).ready(function(){

	if($('.form-horizontal').length){
		validate('form-horizontal');
	}

});

$(document)

	.on('click', '#tab_register', function(){
		$('#tab_login').removeClass('active');
		$(this).addClass('active');
		$('#form_login').data('bootstrapValidator').resetForm();
		$('#form_register')[0].reset();
		$('#form_register').removeClass('hide');
		$('#form_login').addClass('hide');
	})
	.on('click', '#tab_login', function(){
		$(this).addClass('active');
		$('#form_register').data('bootstrapValidator').resetForm();
		$('#tab_register').removeClass('active');
		$('#form_register').addClass('hide');
		$('#form_login')[0].reset();	
		$('#form_login').removeClass('hide');

	})

	.on('click','#btn_register', function(e){

		e.preventDefault();
		var form = $('#form_register');
		var validator = form.data('bootstrapValidator');
		validator.validate();
		if(!validator.isValid()){
			return false;
		}
		
		var form_data = {
				first_name : $('#first_name').val(),
				last_name : $('#last_name').val(),
				phone_number : $('#phone_number').val(),
				email_id : $('#email_id').val(),
				password : $('#password').val(),
				confirm_password : $('#confirm_password').val() 
		}
		$.ajax({
			url : '/components/user.cfc?method=createNewUser',
			type : 'POST',
			dataType : 'json',
			data : form_data,
			success : function(result) {
				
				if(result.sessionExist){
					showHomePage(result.userName);
				}
				form.data('bootstrapValidator').resetForm();
				form[0].reset();
				if(result.error.length){
					showAlert('danger',result.error);
					return false;
				}
				
				showAlert('success','You have successfully registered. Please login to get started.');
			
			},
			failure :  function(data){
			
				showAlert('error','Facing some issue, Please try again after some time.');
			
			}
		});
		
	})

	.on('click','#btn_login', function(e){

		e.preventDefault();
		var form = $('#form_login');
		var validator = form.data('bootstrapValidator');
		validator.validate();
		if(!validator.isValid()){
			return false;
		}
		var user_detail = {
			email_id : $('#user_email').val(),
			password : $('#login_password').val()	
		}
		$.ajax({
			url : '/components/user.cfc?method=userLogin',
			type : 'POST',
			dataType : 'json',
			data : user_detail,
			success : function(result) {
			
				
				if(result.error.length){
					showAlert('danger',result.error);
					form.data('bootstrapValidator').resetForm();
					form[0].reset();
					return false;
				}
				
				//change page
				showHomePage(result.userName);
			
			},
			failure :  function(data){
			
				showAlert('error','Facing some issue, Please try again after some time.');
			
			}
		});
	})	

	.on('click','#logout', function(e){

		e.preventDefault();
		$.ajax({
			url : '/components/user.cfc?method=userLogout',
			type : 'GET',
			dataType : 'json',
			success : function(result) {
				
				if(result.error.length){
					showAlert('danger',result.error);
					return false;
				}
				showForm();
				showAlert('success','You have successfully logged out.');
				
			
			},
			failure :  function(data){
			
				showAlert('error','Facing some issue, Please try again after some time.');
			
			}
		})

	});


