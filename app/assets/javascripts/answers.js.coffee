
class @Answer
  constructor: (@answer_id) ->

    this.$el = $(".answer#answer_#{@answer_id}")
    this.$body = this.$el.find(".answer-body")
    this.$attachments = this.$el.find(".attachments")
    this.$rating = this.$el.find(".rating")
    this.$voteControls = this.$el.find(".vote_controls")
    this.$comments = this.$el.find(".comments")
    this.$commentsPanel = this.$el.find(".comments .panel-body") 
    this.$comment = this.$el.find(".comment")
    this.$commentLink = this.$el.find(".comment-edit-link")
    this.$cancelCommentLink = this.$el.find(".cancel-comment")
    this.$commentForm = this.$el.find(".new_comment_form")
    this.$editForm = this.$el.find(".edit_answer")
    this.$editLink = this.$el.find(".edit_link")
    this.comments = []
    @bindElements()
    @loadComments()
    @setAjaxHooks()



  loadComments: ->
    this.$comment.each (i, e) =>
      id = e.id.split("_")[1]
      this.comments[id] = new Comment(id, "answer", @answer_id)

  bindElements: ->
    this.$editLink.click (e) =>
      e.preventDefault()
      @showEditForm()
      false

    this.$commentLink.click (e) =>
      e.preventDefault()
      @showCommentForm()

    this.$cancelCommentLink.click (e) =>
      e.preventDefault()
      @hideCommentForm()  

  setAjaxHooks: ->
    that = this

    this.$editForm.on "ajax:error", (e, xhr, status) ->
      # console.log that.renderFormErrors
      that.renderFormErrors($(this), xhr.responseJSON)

    this.$commentForm.on "ajax:error", (e, xhr, status) ->
      that.renderFormErrors($(this), xhr.responseJSON)  

  destroyComment: (data) ->
    comment = @comments[data.id]
    comment.destroy()          

  updateComment: (data) ->
    comment = @comments[data.id]
    comment.update(data)    

  createComment: (data) ->
    comment = HandlebarsTemplates['comments/comment'](data)
    this.$commentsPanel.append(comment)  
    @comments[data.id] = new Comment(data.id, "answer", @answer_id)  
    @hideCommentForm()

  updateBody: (data) ->
    body = HandlebarsTemplates['answers/body'](data)
    this.$body.html(body)  

  updateAttachments: (data) ->
    attachments = HandlebarsTemplates['answers/attachments'](data)
    this.$attachments.html(attachments)  



  showEditForm: ->
    this.$editForm.removeClass("hidden")

  
  hideEditForm: ->
    this.$editForm.addClass("hidden")
    @clearFormErrors(this.$editForm)

  showCommentForm: ->
    this.$commentForm.removeClass("hidden")

  hideCommentForm: ->
    this.$commentForm.addClass("hidden")
    this.$commentForm[0].reset()

  update: (data) ->
    body = HandlebarsTemplates['answers/body'](data)
    @hideEditForm()  
    this.$body.html(body) 
    attachments = HandlebarsTemplates['answers/attachments'](data)
    this.$attachments.html(attachments)

  destroyAnswer: ->
    console.log this
    this.$el.remove()
  
  voteUp: ->
    rating = parseInt(this.$rating.text(), 10)
    this.$rating.text(rating + 1)
    this.$voteControls.hide() 

  voteDown: ->
    rating = parseInt(this.$rating.text(), 10)
    this.$rating.text(rating - 1)
    this.$voteControls.hide() 
  
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


