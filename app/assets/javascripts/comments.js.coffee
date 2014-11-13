# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/


# $ ->

#   $('.comment-edit-link').click (e) ->
#     e.preventDefault()
#     form = this.nextSibling
#     $(form).removeClass("hidden").show()


class @Comment
  constructor: (@comment_id, @commentable_type, @commentable_id) ->
    this.$el = $(".comment#comment_#{@comment_id}")
    this.$body = this.$el.find(".body")
    this.$editLink = this.$el.find(".edit_comment")
    
    
    this.$updateFormHolder = this.$el.find(".update_form_holder")
    @bindElements()
    # @setAjaxHooks()

    


  setAjaxHooks: ->
    that = this

    this.$updateCommentForm.on "ajax:error", (e, xhr, status) ->

      that.renderFormErrors($(this), xhr.responseJSON)

  

  bindCancelLink: ->
    that = this

    this.$cancelLink = this.$el.find(".cancel-comment")
    this.$cancelLink.on "click", (e) =>
      e.preventDefault()
      @hideCommentForm()
      false

  bindElements: ->
    that = this
  
    this.$editLink.on "click", (e) =>
      e.preventDefault()
      @showCommentForm()
      false

  update: (data) ->
    body = HandlebarsTemplates['comments/body'](data)
    this.$body.html(body)
    @hideCommentForm()
    
  destroy: ->
    this.$el.remove()

  showCommentForm: ->

    if this.$updateFormHolder.children().length == 0
      this.$updateFormHolder.append(HandlebarsTemplates['comments/update_form']({id: @comment_id, body: this.$body.text()}))

    this.$updateCommentForm = this.$el.find(".update_form")
    this.$updateCommentForm.removeClass("hidden")

    @bindCancelLink()
    @setAjaxHooks()



  hideCommentForm: ->
    this.$updateCommentForm.addClass("hidden")
    clearFormErrors(this.$updateCommentForm)
    
    # $(".update_form").hide()
    # this.$updateForm.hide()
    # this.$updateForm[0].reset()
    # 
    # 
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

 
