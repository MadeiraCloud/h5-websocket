
Package.describe(
	{
	  summary: "Redis Client"
	}
	);

Npm.depends(
	{
		redis: '0.8.3'
	}
	);

Package.on_use(
	function (api)
		{
			api.add_files('redis.js', 'server');  
		}
	);
