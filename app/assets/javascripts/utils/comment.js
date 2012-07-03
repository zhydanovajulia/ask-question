var Comment = {
	init: function () {
  	  this.bindings();
  	},
 	bindings: function() {
 		$('a.cancel-comment').live('click', function(){
 			$(this).closest('.edit_comment').parent().slideUp('slow');
 			return false;
 		})
 	}

};

var Answer = {
	init: function () {
		this.bindings();
	},
	bindings: function() {
		  $('a.cancel-comment').click(function(){
    $(this).closest('.add-comment').slideUp('slow');
    return false;
  });
	}
};

$(function(){
	Answer.init();
  Comment.init();
})