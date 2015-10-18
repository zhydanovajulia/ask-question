Tags =
  init: ->
    @hiddenField = $('#question_tag_list')
    @binding()
    if $('body.questions.edit').length || $('body.questions.new').length
      @getTags()
    if $('body.questions.index').length
      @renderTagsCloud()
  binding: ->
    $('.tags-cloud span').on 'click', ->
      $('#tag').val $(this).text()
      $('.form_for_tag').submit()

  getTags: ->
    qid = $('#tags').data('question-id')
    $.ajax
      url: $('#tags').data('tags-url')
      data: {question_id: qid}
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

  $('form.edit_question').on 'submit', ->
    Tags.updateHiddenInput()

  $('form.new_question').on 'submit', ->
    Tags.updateHiddenInput()
