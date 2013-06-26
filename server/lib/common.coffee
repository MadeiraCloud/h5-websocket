
@REQUEST_CODE = {
	OPS_APP_CREATE                       :    'Forge.App.Create'
	OPS_APP_TERMINATE                    :    'Forge.App.Terminate'
	OPS_APP_RENAME                       :    'Forge.App.Rename'
	OPS_APP_START                        :    'Forge.App.Start'
	OPS_APP_STOP                         :    'Forge.App.Stop'
	OPS_APP_REBOOT                       :    'Forge.App.Reboot'
	OPS_APP_SAVEAS                       :    'Forge.App.SaveAs'
	OPS_APP_UPDATE                       :    'Forge.App.Update'
	OPS_APP_CLONE                        :    'Forge.App.Clone'
	OPS_APP_NOTIFY                       :    'Forge.App.Notify'

	# ---- Stack ----
	OPS_STACK_CREATE                     :    'Forge.Stack.Create'
	OPS_STACK_REMOVE                     :    'Forge.Stack.Remove'
	OPS_STACK_RENAME                     :    'Forge.Stack.Rename'
	OPS_STACK_SAVE                       :    'Forge.Stack.Save'
	OPS_STACK_SAVEAS                     :    'Forge.Stack.SaveAs'
	OPS_STACK_RUN                        :    'Forge.Stack.Run'

	#----- Guest -----
	OPS_GUEST_INVITE                     :    'Forge.Guest.Invite'
	OPS_GUEST_ACCESS                     :    'Forge.Guest.Access'
	OPS_GUEST_EXPIRE                     :    'Forge.Guest.Expire'

	#----- Notify -----
	OPS_NOTIFY_EMAIL                     :    'Forge.Notify.Email'

}


@REQUEST_STATE = {

	STATE_OPS_PENDING					 :    "Pending"
	STATE_OPS_INPROCESS					 :    "InProcess"
	STATE_OPS_DONE						 :    "Done"
	STATE_OPS_FAILED					 :    "Failed"
	STATE_OPS_CANCELLED					 : 	  "Cancelled"
	
}

@ERROR_CODE = {
	# session
	INVALID_SESSION						 :	  "Invalid Session"
	INVALID_SESSION_DETAIL				 : 	  "Please check your session id or relogin"
	# redis
	REDIS_CONFIG						 :	  "Invalid redis config"
	# request
	INVALID_REQUEST						 :	  "Invalid Request Id"
	INVALID_REQUEST_DETAIL				 :	  "Please check your request id"
}