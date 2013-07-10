$(document).bind("mobileinit", 
		function(){
			$.extend( $.mobile , 
					{autoInitializePage: false, ajaxEnabled: false, linkBindingEnabled: false, loadingMessage: ''}
			)
	}
);