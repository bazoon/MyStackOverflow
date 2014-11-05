$ ->
  #TODO: class, namespace

  createAnswer = (answer) ->
    answer = HandlebarsTemplates['answers/answer'](answer)
    $(".answers").append(answer)
    window.clearFormErrors($(".answer_form form"))

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

  hideCommentForm = ->
    $(".edit_comment").hide() 

  hideNewCommentForm = ->
    $(".new_comment_form").hide() 
    window.clearFormErrors($(".new_comment_form"))


  createQuestionComment = (data) ->
    comment = HandlebarsTemplates['comments/comment'](data)
    $(".question .comments .panel-body").append(comment)  
    hideNewCommentForm()

  createAnswerComment = (data) ->
    comment = HandlebarsTemplates['comments/comment'](data)
    $(".answer[data-id='"+data.commentable.id+"'] .comments .panel-body").append(comment)
    hideNewCommentForm()
 
  createComment = (data) ->
    if data.comment.commentable_type == "Question"
      createQuestionComment(data.comment)
    else
      createAnswerComment(data.comment)

  updateComment = (data) ->
    body = HandlebarsTemplates['comments/body'](data)
    console.log body
    $("#comment_" + data.id+" .body").html(body)
    hideCommentForm()

  destroyComment = (id) ->
    $("#comment_#{id}").remove()


  # PrivatePub.subscribe '/questions' , (data, channel) ->

  #   if (typeof data.create_answer != 'undefined')
  #     createAnswer(data.create_answer)
  #   if (typeof data.update_answer != 'undefined')
  #     updateAnswer(data.update_answer)
  #   if (typeof data.destroy_answer != 'undefined')
  #     destroyAnswer(data.destroy_answer)
  #   if (typeof data.vote_up_question != 'undefined')
  #     voteUpQuestion(data.vote_up_question)
  #   if (typeof data.vote_down_question != 'undefined')
  #     voteDownQuestion(data.vote_down_question)
  #   if (typeof data.vote_up_answer != 'undefined')
  #     voteUpAnswer(data.vote_up_answer)
  #   if (typeof data.update_question != 'undefined')
  #     updateQuestion(data.update_question)
  #   if (typeof data.create_comment != 'undefined')
  #     createComment(data.create_comment)
  #   if (typeof data.update_comment != 'undefined')
  #     updateComment(data.update_comment.comment)
  #   if (typeof data.destroy_comment != 'undefined')
  #     destroyComment(data.destroy_comment)
    

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

      $(".new_comment_form").on 'ajax:error', (event, xhr, status, error) ->
        form = $(this)
        renderFormErrors(form, xhr.responseJSON)
  


  # $(".answer_form form").on "ajax:success", (e, data, status, xhr) ->
  #   answer = HandlebarsTemplates['answers/answer'](xhr.responseJSON)
  #   $(".answers").append(answer)
  #   setUpdateSuccessHook()
  #   setUpdateErrorHook()
  #   clearFormErrors($(this))

  $(".answer_form form").on "ajax:error", (event, xhr, status, error) ->
    window.renderFormErrors($(this), xhr.responseJSON)
  

  # $(".edit_question").on 'ajax:error', (event, xhr, status, error) ->
  #     # form = $(this)
  #     # renderFormErrors(form, xhr.responseJSON)
  #     alert('ER')  

  # setUpdateSuccessHook() 

  # setUpdateErrorHook() 
  # setUpdateErrorHook()
  
