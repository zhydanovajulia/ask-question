Tags =
  init: (options)->
    @hiddenField = $('#question_tag_list')
    @getTags()
    @renderTagsCloud(options)
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

  renderTagsCloud: ->
    $.ajax
      url: $('.tags-cloud').data('tags-url')
      success: (data)->
        $('.tags-cloud').jQCloud(data.tag_cloud)
$ ->
  Tags.init()

  $('form.edit_question').live 'submit', ->
    Tags.updateHiddenInput()

  $('form.new_question').live 'submit', ->
    Tags.updateHiddenInput()
