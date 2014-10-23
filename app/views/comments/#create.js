var commentable_class = "<%= @commentable.class.to_s.underscore %>"
var commentable_id = "<%= @commentable.id %>"
var commentable_id_selector = "[data-id='"+commentable_id+"']"
var commentable_class_selector = '.' + commentable_class
var new_comment_form = ".new_comment_form[data-id='"+commentable_id+ "'][data-object='"+commentable_class+"']"

// alert(commentable_class_selector+commentable_id_selector + ' .comments')

$(commentable_class_selector+commentable_id_selector + ' .comments').html('<%= j render partial: 'comments/comments', locals: { commentable: @commentable } %>')
$(new_comment_form).hide()
