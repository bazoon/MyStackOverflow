var commentable_class = "<%= @comment.commentable.class.to_s.underscore %>"
var commentable_id = "<%= @comment.commentable.id %>"
var commentable_id_selector = "[data-id='"+commentable_id+"']"
var commentable_class_selector = '.' + commentable_class

$(commentable_class_selector+commentable_id_selector + ' .comments').html('<%= j render partial: 'comments/comments', locals: { commentable: @comment.commentable } %>')


// $('#<%=@comment.commentable.class_underscore%>_<%=@comment.commentable.id%> .comments').html('<%= j render partial: 'comments/comments', locals: { commentable: @comment.commentable } %>')
// $('comment_update_form_<%= @comment.commentable.id%>').hide()