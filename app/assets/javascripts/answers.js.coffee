$ ->



  createAnswer = (answer) ->
    
    answer = HandlebarsTemplates['answers/answer'](answer)
      
    # alert(answer)
    
    $(".answers").append(answer)
    # alert(xhr.responseText)         
    # $(".answers").append(answer)
    # setUpdateSuccessHook()
    # setUpdateErrorHook()
    # clearFormErrors($(".answer_form form"))



  # PrivatePub.subscribe '/questions' , (data, channel) ->
  #   alert(data.answer)





  PrivatePub.subscribe '/questions' , (data, channel) ->
    # alert($.parseJSON(data.answer).answer)
    
    answer = $.parseJSON(data.answer)

    createAnswer(answer)



 
  clearFormErrors = (form) ->
    form.removeClass("has-error")
    form.find(".alert.alert-danger").remove()
    formGroup = form.find(".has-error")
    formGroup.find(".help-block.error").remove()
    formGroup.removeClass("has-error")
    form[0].reset()


  renderFormErrors = (form, response) ->

    unless form.hasClass("has-error")
      form.addClass("has-error")
      form.prepend("<div class='alert alert-danger has-error'>Please review the problems below:</div>")
      
      for field, error of response
        field = form.find(".form-control[id$=#{field}]")
        formGroup = field.parents(".form-group")
        # formGroup.addClass("has-error") 
        
        formGroup.append("<span class='help-block error'>#{error[0]}</a>")

#   setUpdateSuccessHook = ->
#     $(".update_form").on "ajax:success",  (e, data, status, xhr) ->
#       data = $.parseJSON(xhr.responseText)
#       body = HandlebarsTemplates['answers/body'](data)
#       $(".update_form").hide()
#       $(".answer[data-id='#{data.answer.id}'] .answer-body").html(body) 
#       attachments = HandlebarsTemplates['answers/attachments'](data)
#       $(".answer[data-id='#{data.answer.id}'] .attachments").html(attachments)
#       clearFormErrors($(this))

#   setUpdateErrorHook = ->
#     $(".update_form").on 'ajax:error', (event, xhr, status, error) ->
#       form = $(this)
#       renderFormErrors(form, xhr.responseJSON)


# $(".answer_form form").on "ajax:success", (e, data, status, xhr) ->
#   answer = HandlebarsTemplates['answers/answer'](xhr.responseJSON)
#   # alert(answer)
#   # alert(xhr.responseText)         
#   $(".answers").append(answer)
#   setUpdateSuccessHook()
#   setUpdateErrorHook()
#   clearFormErrors($(this))

#   $(".answer_form form").on "ajax:error", (event, xhr, status, error) ->
#     renderFormErrors($(this), xhr.responseJSON)
  
#   setUpdateSuccessHook() 

#   setUpdateErrorHook() 
  
