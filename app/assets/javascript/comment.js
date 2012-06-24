$(function(){
  $('a.cancel-comment').click(function(){
    $(this).closest('.add-comment').slideUp('slow');
    return false;
  })
})