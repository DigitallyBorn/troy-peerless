form = $('#document_upload_form')
success_url_field = form.find('[name=success_action_redirect]')
original_url = success_url_field.val()
category_field = form.find('#document_category')
title_field = form.find('#document_title')

update_success_url = () ->
  category =
  success_url_field.val("#{original_url}?category=#{escape category_field.val()}&title=#{escape title_field.val()}")

form.find(':input').change update_success_url
