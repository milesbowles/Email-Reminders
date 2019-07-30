# Set time interval to past 5 minutes
set timeInterval to (current date) - 300

# Calculate date time for midnight today
set currentDay to (current date) - (time of (current date))
# Calculate date time for 9:00pm today
set reminderDate to currentDay + (21 * hours)

# Access Mail application
tell application "Mail"
	
	check for new mail
	delay 1
	
	set newMail to (messages of inbox whose date received comes after timeInterval)
	set recent to count of newMail
	
	if recent > 0 then
		
		set theMessage to item 1 of newMail
		set messageID to message id of theMessage
		set messageURL to "message://" & "%3c" & messageID & "%3e"
		set messageSender to sender of theMessage
		set senderName to extract name from messageSender
		set messageDescription to theMessage's content
		set messageSubject to theMessage's subject
		
	end if
	
end tell

# Access Reminders application
tell application "Reminders"
	
	if recent > 0 then
		
		# Select list in reminders	
		set myList to list "Email"
		
		tell myList
			
			# Create reminder
			set newReminder to make new reminder
			set name of newReminder to "Reply to " & senderName
			set body of newReminder to messageSubject & return & messageDescription & return & return & return & messageURL
			set priority of newReminder to 9
			set remind me date of newReminder to reminderDate
			
		end tell
		
	end if
	
end tell
