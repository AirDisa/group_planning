$(document).ready(function(){
  // Validate join form before submit
  $('.new_user input[name="user[email]"]').blur(checkForUniqueEmail);
  $('.new_user input[name="user[first_name]"]').blur(checkFirstName);
  $('.new_user input[name="user[last_name]"]').blur(checkLastName);
  $('.new_user input[name="user[password]"]').blur(checkPassword);
  $('.new_user input[name="user[password_confirmation]"]').blur(checkPasswordConfirmation);
  $('.new_user').submit(validateNewUser);
});

var checkForUniqueEmail = function(){
  $('ul#errors li.email').remove();
  var data  = $(this).serialize();
  $.post('/validate/email', data, function(response){
    if (response == "invalid") {
      $('ul#errors').append('<li class="email">Email must be unique</li>').hide().slideDown(100)}; 
  });
};
var checkFirstName = function() {
  $('ul#errors li.firstName').remove();
  var firstName = $('form input[name="user[first_name]"]').val();
  var nameRegex = /.{2,}/;
  if (!nameRegex.test(firstName)) {
    $('ul#errors').append('<li class="firstName">First name must be at least 2 letters long</li>').hide().slideDown(100)};
};
var checkLastName = function() {
  $('ul#errors li.lastName').remove();
  var lastName = $('form input[name="user[last_name]"]').val();
  var nameRegex = /.{2,}/;
  if (!nameRegex.test(lastName)) {
    $('ul#errors').append('<li class="lastName">Last name must be at least 2 letters long</li>').hide().slideDown(100)};
};
var checkPassword = function() {
  $('ul#errors li.password').remove();
  var password = $('form input[name="user[password]"]').val();
  var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$/;
  if (!passwordRegex.test(password)) {
    $('ul#errors').append('<li class="password">Password must be at least 6 characters long, \
      have at least one capital letter, and contain at least one number. \
      </li>').hide().slideDown(300) };
};
var checkPasswordConfirmation = function() {
  $('ul#errors li.passwordMatch').remove();
  var password = $('form input[name="user[password]"]').val();
  var passwordConfirmation = $('form input[name="user[password_confirmation]"]').val();
  if (password != passwordConfirmation) {
    $('ul#errors').append('<li class="passwordMatch">Passwords do not match</li>').hide().slideDown(100) };
};
var validateNewUser = function(e){
  if ($('ul#errors li').length > 0) {
    e.preventDefault();
  }
};
