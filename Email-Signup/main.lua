local coordLogo = { x = 640/2 - 470/2, y = 50 }
local coordLabel1 = { x = 10, y = 450 }
local coordLabel2 = { x = 10, y = 475 }
local coordLabel3 = { x = 10, y = 500 }
local coordLabel4 = { x = 10, y = 525 }
local coordLabel5 = { x = 10, y = 550 }
local coordButton = { x = 640/2 - 250, y = 650 }
local font = Font.new( "KiriFont_20.txt", "KiriFont_20.png" )

local logo = Bitmap.new( Texture.new( "logo.png" ) )
logo:setPosition( coordLogo.x, coordLogo.y )
stage:addChild( logo )

local label_signup = TextField.new( font, "Want a reminder email after Maker Faire?" )
label_signup:setPosition( coordLabel1.x, coordLabel1.y )
stage:addChild( label_signup )

local label_signup2 = TextField.new( font, "Sign up, and we will send you one email" )
label_signup2:setPosition( coordLabel2.x, coordLabel2.y )
stage:addChild( label_signup2 )

local label_signup3 = TextField.new( font, "after Maker Faire about our meetings," )
label_signup3:setPosition( coordLabel3.x, coordLabel3.y )
stage:addChild( label_signup3 )

local label_signup4 = TextField.new( font, "classes, and events!" )
label_signup4:setPosition( coordLabel4.x, coordLabel4.y )
stage:addChild( label_signup4 )

local label_status = TextField.new( font, ":D" )
label_status:setPosition( coordLabel5.x, coordLabel5.y )
stage:addChild( label_status )

local button_email = Bitmap.new( Texture.new( "email_button.png" ) )
button_email:setPosition( coordButton.x, coordButton.y )
stage:addChild( button_email )

local timer = Timer.new( 1000, 5 )

local function OnTimeout( event )
	label_status:setText( ":D" )
		label_status:setTextColor( 0x000000 )
end

local function SaveEmailAddress( event )
	
	require "lfs"
	local path = "/sdcard/CCCKC/"
	lfs.mkdir( path )
	local filename = "email_signups.txt"
	
    local destFile = io.open( path .. filename, "ab" )
	
	if destFile == nil then
		prefix = "|D|"
		filename = path .. filename
		destFile = io.open( filename, "ab" )
	end
	
	if destFile == nil then
		label_status:setText( "Error opening file '" .. filename .. "'!" )
		label_status:setTextColor( 0xff0000 )
	else
		destFile:write( "\n" )
		destFile:write( event.text .. "\t" .. os.date( "(%Y-%m-%d %I:%M %p)" ) )
	
		destFile:close()
		label_status:setText( "Registered email - Thank you!" )
		label_status:setTextColor( 0x119743 )
	end
	
	timer:addEventListener( Event.TIMER_COMPLETE, OnTimeout )
	timer:start()
end

local function HandleButtonClick( event )
	if ( button_email:hitTestPoint( event.x, event.y ) ) then
		local textInputDialog = TextInputDialog.new( "Email Address", "Enter your email address", "", "Cancel", "OK" )

		textInputDialog:addEventListener( Event.COMPLETE, SaveEmailAddress, self )
		textInputDialog:show()
	end
end

button_email:addEventListener( Event.MOUSE_DOWN, HandleButtonClick, self )
