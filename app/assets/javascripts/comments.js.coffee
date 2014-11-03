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
    this.$editLink = this.$el.find(".edit_comment")
    this.$cancelLink = this.$el.find(".cancel-comment")
    this.$updateForm = this.$el.find(".update_form")
    @foo = 'foo'
    @bindElements()



  bindElements: ->
    that = this
    
    $(".cancel-comment").on "click", (e) =>
      console.log 'cancel click'
      # console.log this.comment_id
      # that.$updateForm.addClass("hidden")

      # for k,v of that.$updateForm
      #   if typeof v == "string"
      #     console.log "#{k}: #{v}"
      
      # console.log "=================="

      # for k,v of $(".update_form")
      #   if typeof v == "string"
      #     console.log "#{k}: #{v}"
          
      # that.$updateForm.hide()

      # that.hideCommentForm()

    this.$el.parents(".comments").on "click", ".cancel-comment", (e) ->
      e.preventDefault()
      console.log 'Cancel'
      # that.$el.siblings(".edit-form").remove()
      # that.$el.show()
    
    $(".edit_comment").on "click", (e) ->
      console.log 'edit'
      e.preventDefault()
      
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
    console.log 'update'
    body = HandlebarsTemplates['comments/body'](data)
    this.$body.html(body)
    @hideCommentForm()
    
  destroy: ->
    this.$el.remove()

  showCommentForm: ->
    this.$updateForm.removeClass("hidden")

  hideCommentForm: ->
    # this.$updateForm.addClass("hidden")
    $(".comment#1").hide()
    # $(".update_form").hide()
    # this.$updateForm.hide()
    # this.$updateForm[0].reset()
 
