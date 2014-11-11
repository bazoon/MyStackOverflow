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
    this.$cancelLink = this.$el.find(".cancel-comment")
    this.$updateForm = this.$el.find(".update_form")
    @bindElements()
    @setAjaxHooks()

    


  setAjaxHooks: ->
    that = this

    this.$updateForm.on "ajax:error", (e, xhr, status) ->

      that.renderFormErrors($(this), xhr.responseJSON)

  


  bindElements: ->
    that = this

    # this.$updateForm.on "ajax:success", (e, data, status, xhr) ->
    #   # that.$body.html('NEW23')
    #   # that.$updateForm.addClass("hidden")


    this.$cancelLink.on "click", (e) =>
      e.preventDefault()
      @hideCommentForm()
      false

      # for k,v of that.$updateForm
      #   if typeof v == "string"
      #     console.log "#{k}: #{v}"
      
      # console.log "=================="

      # for k,v of $(".update_form")
      #   if typeof v == "string"
      #     console.log "#{k}: #{v}"
          
      # that.$updateForm.hide()

      # that.hideCommentForm()

    # this.$el.parents(".comments").on "click", ".cancel-comment", (e) ->
    #   e.preventDefault()
    #   console.log 'Cancel'
      
    this.$editLink.on "click", (e) =>
      e.preventDefault()
      @showCommentForm()
      false
      # $(".update_form").removeClass("hidden")
      
    #   $(".comment-form").slideUp()
    #   $(".edit-form").prev().show().end().remove()
    

    # this.$el.on "click", (e) =>
      
    #   e.preventDefault()
    #   @showCommentForm()

    # this.$cancelLink.click (e) =>  
    #   e.preventDefault()
    #   console.log 'cancel'
    #   @hideCommentForm()  

  update: (data) ->
    body = HandlebarsTemplates['comments/body'](data)
    this.$body.html(body)
    @hideCommentForm()
    
  destroy: ->
    this.$el.remove()

  showCommentForm: ->
    this.$updateForm.removeClass("hidden")

  hideCommentForm: ->
    this.$updateForm.addClass("hidden")
    
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

 
