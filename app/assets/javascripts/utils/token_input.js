(function ($) {
  var TokenInput = function (input, options) {
    this.tagList = {};
    this.tagSet = options.possibleTags || [];
    this.existingTags = options.existingTags || [];
    this.$input = $(input);

    var initialize = function () {
      this.$input.after(this.template());
      this.$tokenDiv = this.$input.next();
      this.$tokenInput = this.$tokenDiv.find('input');
      this.$tokenUl = this.$tokenDiv.find('ul');
      this.$input.hide();
      this.populate();
      this.bindings();
    };
    initialize.call(this);
  };

  TokenInput.prototype = {
    populate: function () {
      var tags = this.existingTags;
      if (tags) {
        for (var i in tags) {
          this.addTag(tags[i]);
        }
      }
    },
    bindings: function () {
      var that = this;
      this.$tokenInput.on('keydown.token-input', function (e) {
        var tag = $(this).val();
        if(e.keyCode === 9){
          that.addTag.call(that, tag);
          e.preventDefault();
        }
      });
      this.$tokenInput.on('keyup.token-input', function () { that.findTags.apply(that, arguments); });
      this.$tokenDiv.on('click.token-input', 'a', function () { that.removeTag.apply(that, arguments); });
      this.$tokenInput.on('keydown',  function () { that.tagsNavigator.apply(that, arguments); });
      $('body').on('click', function (e) {
        if ( !$(e.target).closest('.token-input-match-tags-list').length ){
          that.hidePopup();
        }
      });
    },
    showPopup: function (matchTags) {
      this.$tokenDiv.find('.token-input-match-tags-list').remove();
      if (matchTags.length) {
        this.$tokenDiv.append("<ul class='token-input-match-tags-list'><li>" + matchTags.join('</li><li>') + "</li></ul>");
      }
      this.initSelector();
    },
    hidePopup: function () {
      this.$tokenDiv.find('.token-input-match-tags-list').remove();
    },
    template: function () {
      return "<div class='token-input-wrapper'><ul><li class='token-li-input'><input /></li></ul></div>";
    },
    liTemplate: function (tag) {
      return "<li><span>" + tag + "</span><a href='#' class='delete-tag'>[X]</a></li>";
    },
    findMatch: function (tag) {
      var matchTags = [];
      if ( !$.trim(tag).length ) { return []; }
      for (var i in this.tagSet) {
        if (this.tagSet[i].match(tag)) {
          matchTags.push(this.tagSet[i].replace(tag, "<em>" + tag + "</em>"));
        }
      }
      return matchTags;
    },
    removeTag: function (e) {
      var tag = $(e.target).prev().text();
      delete this.tagList[tag];
      $(e.target).parent().remove();
    },
    addTag: function (tagString) {
      var tag = $.trim( tagString );
      if (tag.length && !this.tagList[tag]) {
        this.tagList[tag] = true;
        this.$tokenUl.find('.token-li-input').before( this.liTemplate(tag) );
        this.$tokenUl.find('.token-li-input input').val('');
      }
    },
    findTags: function (e) {
      var tag = $.trim( $(e.target).val() ),
          matchTags = this.findMatch(tag);
      if ( $(this).data('previousValue') !== tag ) {
        this.showPopup(matchTags);
      }
      $(this).data('previousValue', tag);
    },
    initSelector: function () {
      this.$tokenDiv.find('.token-input-match-tags-list li:first').addClass('selected');
    },
    tagsNavigator: function (e) {
      var $matchTagsList,
          $active;
      $matchTagsList = this.$tokenDiv.find('.token-input-match-tags-list');
      if ( $matchTagsList.length) {
        switch (e.keyCode){
          case 40:
            $active = $matchTagsList.find('.selected');
            $active.removeClass('selected');
            if ($active.next().length) {
              $active.next().addClass('selected');
            } else {
              $matchTagsList.find('li:first').addClass('selected');
            }
            break;
          case 38:
            $active = $matchTagsList.find('.selected');
            $active.removeClass('selected');
            if ($active.prev().length) {
              $active.prev().addClass('selected');
            } else {
              $matchTagsList.find('li:last').addClass('selected');
            }
            break;
          case 13:
            $active = $matchTagsList.find('.selected');
            this.addTag($active.text());
            e.preventDefault();
            break;
          case 27:
            this.hidePopup();
            break;
        }
      }
    }
  };

  $.fn.tokenInput = function (options) {
    var defaults = {
      possibleTags: ["ruby", "rails", "js"]
    };
    options = $.extend(defaults, options);

    new TokenInput(this, options);
  };
})(jQuery);
