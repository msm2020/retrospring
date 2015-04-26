$(document).on "click", "a[data-action=ab-question-destroy]", (ev) ->
  ev.preventDefault()
  btn = $(this)
  qid = btn[0].dataset.qId
  swal
    title: "Are you sure?"
    text: "The question will be removed."
    type: "warning"
    showCancelButton: true
    confirmButtonColor: "#DD6B55"
    confirmButtonText: "Yes"
    cancelButtonText: "No"
    closeOnConfirm: true
  , ->
    $.ajax
      url: '/ajax/destroy_question' # TODO: find a way to use rake routes instead of hardcoding them here
      type: 'POST'
      data:
        question: qid
      success: (data, status, jqxhr) ->
        if data.success
          if btn[0].dataset.redirect != undefined
            window.location.href = btn[0].dataset.redirect
          else
            $("div.answerbox[data-q-id=#{qid}], div.questionbox[data-id=#{qid}]").slideUp()
        showNotification data.message, data.success
      error: (jqxhr, status, error) ->
        console.log jqxhr, status, error
        showNotification "An error occurred, a developer should check the console for details", false
      complete: (jqxhr, status) ->
