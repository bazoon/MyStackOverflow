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
    this.$el = $(".comment##{@comment_id}")
    this.$body = this.$el.find(".body")
    this.$editLink = this.$el.find("#edit_comment#{@comment_id}")
    this.$cancelLink = this.$el.find(".cancel-comment")
    this.$updateForm = this.$el.find(".update_form")

    @bindElements()

  bindElements: ->
    
    this.$editLink.click (e) =>
      e.preventDefault()
      @showCommentForm()

    this.$cancelLink.click (e) =>  
      e.preventDefault()
      @hideCommentForm()  

  update: (data) ->
    body = HandlebarsTemplates['comments/body'](data)
    this.$body.html(body)
    @hideCommentForm()
    
  destroy: ->
    this.$el.remove()

  showCommentForm: ->
    # console.log this
    this.$updateForm.removeClass("hidden")

  hideCommentForm: ->
    this.$updateForm.addClass("hidden")
    this.$updateForm[0].reset()
 
