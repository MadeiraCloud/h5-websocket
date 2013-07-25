

Meteor.startup start = () ->


	scribeInit()

	request_publisher 			= new RequestPublisher 

	request_detail_publisher 	= new RequestDetailPublisher

	stack_publisher 			= new StackPublisher

	app_publisher				= new AppPublisher

	app_publisher.publish()
	
	stack_publisher.publish()

	request_publisher.publish()

	request_detail_publisher.publish()