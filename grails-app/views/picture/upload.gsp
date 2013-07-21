<html>
<head>
<title>emote image upload</title>
<script type="text/javascript" src="/emote/js/vendor/jquery-2.0.0.min.js">
</script>
<script type="text/javascript" src="/emote/js/vendor/jquery.form.min.js">
</script>
<script type="text/javascript" >
$(document).ready(function()
		{   
		        $('#uploadForm').ajaxForm({
		        beforeSubmit: function() {
		            $('#results').html('Submitting...');
		        },
		        success: function(data) {
		            var $out = $('#results');
		            $out.html('Your results:');
		            $out.append('<div><pre>'+ data +'</pre></div>');
		            
		        }
		    });
		})    
</script> 
</head>
<body>
<form id='uploadForm' action="save" method="post" enctype="multipart/form-data">
<input type="file" name="content">
<input type="submit" value="load">
</form>
<div id="results"></div></body>
</html>
    