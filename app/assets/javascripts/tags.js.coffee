
$ ->
  $('#question_tag_tokens').tokenInput('/tags', 
  { theme: 'facebook',prePopulate: $('#question_tag_tokens').data('load')})