

Meteor.startup start = () ->


	scribeInit()

	request_publisher 			= new RequestPublisher

	request_detail_publisher 	= new RequestDetailPublisher

	stack_publisher 			= new StackPublisher

	app_publisher				= new AppPublisher

	state_publisher				= new StatePublisher

	import_publisher 			= new ImportPublisher

	import_publisher.publish()

	app_publisher.publish()

	stack_publisher.publish()

	request_publisher.publish()

	request_detail_publisher.publish()

	state_publisher.publish()