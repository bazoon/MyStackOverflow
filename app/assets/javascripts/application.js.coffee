
#= require jquery
#= require bootstrap-sprockets
#= require jquery_ujs
#= require jquery.remotipart
#= require handlebars.runtime
#= require handlebars
#= require private_pub
#= require jquery.tokeninput

#= require jquery_nested_form
#= require_tree ./templates
#= require_tree .

#TODO: ready, вынести common.js

  


clearFormErrors = (form) ->
  form.removeClass("has-error")
  form.find(".alert.alert-danger").remove()
  form.find(".help-block.error").remove()
  form[0].reset()

renderFormErrors = (form, response) ->
  unless form.hasClass("has-error")
    form.addClass("has-error")
    form.prepend("<div class='alert alert-danger has-error'>Please review the problems below:</div>")
    
    for field, error of response.errors
      field = form.find(".form-control[id$=#{field}]")
      formGroup = field.parents(".form-group")
      # formGroup.addClass("has-error") 
      
      formGroup.append("<span class='help-block error'>#{error[0]}</a>")



window.renderFormErrors = renderFormErrors
window.clearFormErrors = clearFormErrors
