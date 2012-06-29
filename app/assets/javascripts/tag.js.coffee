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

  renderTagsCloud: (word_array)->
    $('.tags-cloud').jQCloud(word_array)
$ ->
  word_array = [
    {text: "Lorem", weight: 15},
    {text: "Ipsum", weight: 9, link: "http://jquery.com/"},
    {text: "Dolor", weight: 6, html: {title: "I can haz any html attribute"}},
    {text: "Sit", weight: 7},
    {text: "Amet", weight: 5}
  ]
  Tags.init(word_array, width: 300, height: 200)

  $('form.edit_question').live 'submit', ->
    Tags.updateHiddenInput()

