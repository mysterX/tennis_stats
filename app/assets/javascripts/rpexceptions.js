app.Rpexceptions = function() {
  this._input = $('#country-search-txt');
  this._initAutocomplete();
};

app.Rpexceptions.prototype = {
    _initAutocomplete: function() {
    	var sourceUrl = document.URL;
    	var restPos = sourceUrl.indexOf("/rpexceptions/");
    	sourceUrl = sourceUrl.substring(restPos);
    	console.log('URL=' + document.URL);
	this._input
	    .autocomplete({
		source: sourceUrl,
		appendTo: '#country-search-results',
		select: $.proxy(this._select, this)
	    })
	    .autocomplete('instance')._renderItem = $.proxy(this._render, this);
    },

    _render: function(ul, item) {
	var markup = [
	    '<span class="c_desc">' + item.desc + '</span>'
	];
	return $('<li>')
	    .append(markup.join(''))
	    .appendTo(ul);
    },

    _select: function(e, ui) {
	this._input.val(ui.item.desc);
	return false;
    }
};
