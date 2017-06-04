function showAlert(type, message){
	var alert = $('<div class="alert alert-dismissable fade in"><a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');
	alert.addClass('alert-'+ type);
	alert.append(message);
	$('body').prepend(alert);
	setTimeout(function(){alert.remove();},3000);
}

$(document).ready(function(){
	function validate(){	
		$('.form-horizontal').bootstrapValidator({
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
	if($('.form-horizontal').length){
		validate();
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
			url : '/components/user.cfc?method=loginUser',
			type : 'POST',
			dataType : 'json',
			data : user_detail,
			success : function(result) {
			
				form.data('bootstrapValidator').resetForm();
				form[0].reset();
				if(result.error.length){
					showAlert('danger',result.error);
					form.data('bootstrapValidator').resetForm();
					return false;
				}
				showAlert('success','You have successfully logged in.');
				//change page
				formObject = $('.wrapper').detach();
			
			},
			failure :  function(data){
			
				showAlert('error','Facing some issue, Please try again after some time.');
			
			}
		});
	})	

	.on('click','#btn_logout', function(e){

		e.preventDefault();
		$.ajax({
			url : '/components/user.cfc?method=logoutUser',
			type : 'GET',
			dataType : 'json',
			success : function(result) {
				
				if(result.error.length){
					showAlert('danger',result.error);
					return false;
				}
				showAlert('sucess','You have successfully logged in.');
			
			},
			failure :  function(data){
			
				showAlert('error','Facing some issue, Please try again after some time.');
			
			}
		})
		
		.on( 'status.field.bv', '#form_login', function( e, data ) {

			var $this = $(this);
			var formIsValid = true;

			$( '.form-group', $this ).each( function() {
				formIsValid = formIsValid && $( this ).hasClass( 'has-success' );
			});
			$('.submit-button', $this ).attr( 'disabled', !formIsValid );

		});
	});

