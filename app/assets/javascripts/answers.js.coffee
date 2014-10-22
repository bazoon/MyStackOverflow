$ ->

  createAnswer = (answer) ->
    answer = HandlebarsTemplates['answers/answer'](answer)
    $(".answers").append(answer)
    clearFormErrors($(".answer_form form"))

  updateAnswer = (data) ->
    body = HandlebarsTemplates['answers/body'](data)
    $(".update_form").hide()
    $(".answer[data-id='#{data.answer.id}'] .answer-body").html(body) 
    attachments = HandlebarsTemplates['answers/attachments'](data)
    $(".answer[data-id='#{data.answer.id}'] .attachments").html(attachments)

  destroyAnswer = (id) ->
    $(".answer[data-id='#{id}']").remove()

  voteUpQuestion = (data) ->
    ratingElem = $("#question_rating_" + data.id)
    rating = parseInt(ratingElem.text(), 10)
    ratingElem.text(rating+1)
    $('.question[data-id="'+ data.id+'"] .vote_controls').hide()

  voteDownQuestion = (data) ->
    ratingElem = $("#question_rating_" + data.id)
    rating = parseInt(ratingElem.text(), 10)
    ratingElem.text(rating-1)
    $('.question[data-id="'+ data.id+'"] .vote_controls').hide()

  voteUpAnswer = (data) ->
    ratingElem = $("#answer_rating_" + data.id)
    rating = parseInt(ratingElem.text(), 10)
    ratingElem.text(rating+1)
    $('.answer[data-id="'+ data.id+'"] .vote_controls').hide()
  
  updateQuestion = (data) ->
    body = HandlebarsTemplates['questions/body'](data)
    $(".question .body").html(body)
    title = HandlebarsTemplates['questions/title'](data)
    $(".question .title").html(title)
    attachments = HandlebarsTemplates['questions/attachments'](data)
    $(".question .attachments").html(attachments)
    tags = HandlebarsTemplates['questions/tags'](data)
    $(".question .tags").html(tags)

    

  PrivatePub.subscribe '/questions' , (data, channel) ->

    if (typeof data.create_answer != 'undefined')
      createAnswer(data.create_answer)
    if (typeof data.update_answer != 'undefined')
      updateAnswer(data.update_answer)
    if (typeof data.destroy_answer != 'undefined')
      destroyAnswer(data.destroy_answer)
    if (typeof data.vote_up_question != 'undefined')
      voteUpQuestion($.parseJSON(data.vote_up_question))
    if (typeof data.vote_down_question != 'undefined')
      voteDownQuestion($.parseJSON(data.vote_down_question))
    if (typeof data.vote_up_answer != 'undefined')
      voteUpAnswer($.parseJSON(data.vote_up_answer))
    if (typeof data.update_question != 'undefined')
      updateQuestion(data.update_question)
    
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
  

  # $(".edit_question").on 'ajax:error', (event, xhr, status, error) ->
  #     # form = $(this)
  #     # renderFormErrors(form, xhr.responseJSON)
  #     alert('ER')  

  # setUpdateSuccessHook() 

  setUpdateErrorHook() 
  
