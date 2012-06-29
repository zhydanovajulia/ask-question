Tags =
  init: ->
    @hiddenField = $('#question_tag_list')
    @getTags()
  getTags: ->
    $.ajax
      url: $('#tags').data('tags-url')
      data: $('#tags').data('question-id')
      success: (data)->
        $('#tags').tokenInput({
          possibleTags: data.tags,
          existingTags: data.question_tags
        })
  updateHiddenInput: ->
    @hiddenField.val $.map($('.token-input-wrapper ul li span').not('.token-li-input'), (e)-> $(e).text() )
$ ->
  Tags.init()

  $('form.edit_question').live 'submit', ->
    Tags.updateHiddenInput()

