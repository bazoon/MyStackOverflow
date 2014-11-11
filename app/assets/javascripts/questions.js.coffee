class @Question
  constructor: ->
    this.$el = $(".question")
    this.$rating = this.$el.find(".rating")
    this.$body = this.$el.find(".body")
    this.$attachments = this.$el.find(".attachments")
    this.$comments = this.$el.find(".comments")
    this.$commentsPanel = this.$el.find(".comments .panel-body") 
    this.$comment = this.$comments.find(".comment")
    this.$commentLink = this.$el.find(".comment-edit-link")
    this.$cancelCommentLink = this.$el.find(".cancel-comment")
    this.$commentForm = this.$el.find(".new_comment_form")
    this.$voteControls = this.$el.find(".vote_controls")
    this.$commentLink = this.$el.find(".comment-edit-link")
    this.$cancelCommentLink = this.$el.find(".cancel-comment")
    this.$answers = $(".answers")
    this.$answer = $(".answers .answer")
    this.$answerForm = this.$el.find(".answer_form form")

    @question_id = this.$el.id
    @comments = {}
    @answers = {}
    @loadAnswers()
    @loadComments() 
    @bindElements() 
    @subscribeToPub()
    @setAjaxHooks()

  setAjaxHooks: ->
    that = this


    this.$commentForm.on "ajax:error", (e, xhr, status) ->
      that.renderFormErrors($(this), xhr.responseJSON)  

    this.$answerForm.on "ajax:error", (e, xhr, status) ->
      that.renderFormErrors($(this), xhr.responseJSON)  
  

  bindElements: ->
    
    this.$commentLink.click (e) =>
      e.preventDefault()
      @showCommentForm()

    this.$cancelCommentLink.click (e) =>
      e.preventDefault()
      @hideCommentForm()  

  subscribeToPub: ->
  

    PrivatePub.subscribe '/questions' , (data, channel) =>
      if (typeof data.create_answer != 'undefined')
        @createAnswer(data.create_answer)
      if (typeof data.update_answer != 'undefined')
        @updateAnswer(data.update_answer)
      if (typeof data.destroy_answer != 'undefined')
        @destroyAnswer(data.destroy_answer)
      if (typeof data.vote_up_question != 'undefined')
        @voteUp()
      if (typeof data.vote_down_question != 'undefined')
        @voteDown()
      if (typeof data.vote_up_answer != 'undefined')
        @voteUpAnswer(data.vote_up_answer)
      if (typeof data.vote_down_answer != 'undefined')
        @voteDownAnswer(data.vote_down_answer)
      if (typeof data.update_question != 'undefined')
        updateQuestion(data.update_question)
      if (typeof data.create_comment != 'undefined')
        @createComment(data.create_comment)
      if (typeof data.update_comment != 'undefined')
        @updateComment(data.update_comment.comment)
      if (typeof data.destroy_comment != 'undefined')
        @destroyComment(data.destroy_comment.comment)
  

  destroyComment: (data) ->

    if data.commentable_type == "Question"
      @destroyQuestionComment(data)
    else
      @destroyAnswerComment(data)

  destroyQuestionComment: (data) ->
    console.log 'DLE'
    comment = @comments[data.id]
    comment.destroy()

  destroyAnswerComment: (data) ->
    answer = @answers[data.commentable.id]
    answer.destroyComment(data)    

  updateComment: (data) ->
    if data.commentable_type == "Question"
      @updateQuestionComment(data)
    else
      @updateAnswerComment(data)

  updateQuestionComment: (data) ->
    # alert('COMMENT')
    comment = @comments[data.id]
    
    comment.update(data)

  updateAnswerComment: (data) ->
    answer = @answers[data.commentable.id]
    answer.updateComment(data)
    

  createComment: (data) ->
    if data.comment.commentable_type == "Question"
      @createQuestionComment(data.comment)
    else
      @createAnswerComment(data.comment)


  createQuestionComment: (data) ->
    comment = HandlebarsTemplates['comments/comment'](data)
    this.$commentsPanel.append(comment)
    @comments[data.id] = new Comment(data.id, "question", @question_id)
    @hideCommentForm()

  createAnswerComment: (data) ->
    answer = @answers[data.commentable.id]
    answer.createComment(data)

  voteUpAnswer: (data) ->
    answer = @answers[data.id]
    answer.voteUp()

  voteDownAnswer: (data) ->
    answer = @answers[data.id]
    answer.voteDown()

  destroyAnswer: (id) ->
    answer = @answers[id]
    answer.destroyAnswer()      

  createAnswer: (data) ->
    answer = HandlebarsTemplates['answers/answer'](data)
    this.$answers.append(answer)
    @clearFormErrors(this.$answerForm)
    @answers[data.answer.id] = new Answer(data.answer.id)


  updateAnswer: (data) ->
    answer = @answers[data.answer.id]
    answer.updateBody(data)
    answer.updateAttachments(data)
    answer.hideEditForm()

  loadAnswers: ->
    this.$answer.each (i, e) =>
      id = e.id.split("_")[1]
      @answers[id] = new Answer(id)    

  loadComments: ->
    this.$comment.each (i, e) =>
      id = e.id.split("_")[1]
      @comments[id] = new Comment(id, "question", @question_id)

  voteUp: ->
    rating = parseInt(this.$rating.text(), 10)
    this.$rating.text(rating + 1)
    this.$voteControls.hide() 

  voteDown: ->
    rating = parseInt(this.$rating.text(), 10)
    this.$rating.text(rating - 1)
    this.$voteControls.hide() 
      


  showCommentForm: ->
    this.$commentForm.removeClass("hidden")

  hideCommentForm: ->
    this.$commentForm.addClass("hidden")



  clearFormErrors: (form) ->
    form.removeClass("has-error")
    form.find(".alert.alert-danger").remove()
    form.find(".help-block.error").remove()
    form[0].reset()

  renderFormErrors: (form, response) ->
    unless form.hasClass("has-error")
      form.addClass("has-error")
      form.prepend("<div class='alert alert-danger has-error'>Please review the problems below:</div>")
      
      for field, error of response.errors
        field = form.find(".form-control[id$=#{field}]")
        formGroup = field.parents(".form-group")
        # formGroup.addClass("has-error") 
        
        formGroup.append("<span class='help-block error'>#{error[0]}</a>")
  


@foo.Question = Question

