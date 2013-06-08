Package.describe(
	{
	  summary: "Scribe Client"
	}
	);

Npm.depends(
	{
		scribe: '0.0.9'
	}
	);

Package.on_use(
	function (api)
		{
			api.add_files('scribe.js', 'server');  
		}
	);
