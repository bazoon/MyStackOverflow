
$ ->

  createAnswer = (answer) ->
    answer = HandlebarsTemplates['answers/answer'](answer)
    $(".answers").append(answer)

  updateAnswer = (data) ->
    body = HandlebarsTemplates['answers/body'](data)
    $(".update_form").hide()
    $(".answer[data-id='#{data.answer.id}'] .answer-body").html(body) 
    attachments = HandlebarsTemplates['answers/attachments'](data)
    $(".answer[data-id='#{data.answer.id}'] .attachments").html(attachments)

  destroyAnswer = (id) ->
    $(".answer[data-id='#{id}']").remove()


  PrivatePub.subscribe '/questions' , (data, channel) ->
    
    if (typeof data.create_answer != 'undefined')
      createAnswer($.parseJSON(data.create_answer))
    if (typeof data.update_answer != 'undefined')
      updateAnswer($.parseJSON(data.update_answer))
    if (typeof data.destroy_answer != 'undefined')
      destroyAnswer($.parseJSON(data.destroy_answer))
    


 
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

  # setUpdateSuccessHook = ->
  #   $(".update_form").on "ajax:success",  (e, data, status, xhr) ->
  #     data = $.parseJSON(xhr.responseText)
  #     body = HandlebarsTemplates['answers/body'](data)
  #     $(".update_form").hide()
  #     $(".answer[data-id='#{data.answer.id}'] .answer-body").html(body) 
  #     attachments = HandlebarsTemplates['answers/attachments'](data)
  #     $(".answer[data-id='#{data.answer.id}'] .attachments").html(attachments)
  #     clearFormErrors($(this))

  setUpdateErrorHook = ->
    $(".update_form").on 'ajax:error', (event, xhr, status, error) ->
      form = $(this)
      renderFormErrors(form, xhr.responseJSON)


  # $(".answer_form form").on "ajax:success", (e, data, status, xhr) ->
  #   answer = HandlebarsTemplates['answers/answer'](xhr.responseJSON)
  #   $(".answers").append(answer)
  #   setUpdateSuccessHook()
  #   setUpdateErrorHook()
  #   clearFormErrors($(this))

  $(".answer_form form").on "ajax:error", (event, xhr, status, error) ->
    renderFormErrors($(this), xhr.responseJSON)
  
  # setUpdateSuccessHook() 

  setUpdateErrorHook() 
  
