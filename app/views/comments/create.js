var new_comment_form = "#new_comment_form_<%= @commentable.class.to_s.underscore%>_<%=@commentable.id %>"
$('#<%=@commentable.class.to_s.underscore%>_<%=@commentable.id%> .comments').html('<%= j render partial: 'comments/comments', locals: { commentable: @commentable } %>')
$(new_comment_form).hide()
