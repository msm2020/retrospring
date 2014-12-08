$(document).on "click", "button[name=ab-destroy]", ->
  btn = $(this)
  btn.button "loading"
  aid = btn[0].dataset.aId
  $.ajax
    url: '/ajax/destroy_answer' # TODO: find a way to use rake routes instead of hardcoding them here
    type: 'POST'
    data:
      answer: aid
    success: (data, status, jqxhr) ->
      if data.success
        $("div.answer-box[data-id=#{aid}]").slideUp()
      showNotification data.message, data.success
    error: (jqxhr, status, error) ->
      console.log jqxhr, status, error
      showNotification "An error occurred, a developer should check the console for details", false
    complete: (jqxhr, status) ->
      btn.button "reset"