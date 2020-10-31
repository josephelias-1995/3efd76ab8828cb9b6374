# RubyOnRails-Test


This application is based on postgresql

TO DO:-

1. create database
2. seed the Robot data
3. open postman and trigger post requests to http://127.0.0.1:3000/api/robots/1/orders
4. you can try with the given parameters

Request params:- 

{
	"commandsss": [ "PLACEaaaa", 0, 0, "NORTH",  "MOVE" ]
}


{
	"commands": [ "PLACEaaaa", 0, 0, "NORTH",  "MOVE" ]
}


{
	"commands": [ "PLACE", 0, 0, "NORTH",  "MOVE" ]
}


{
	"commands": [ "PLACE", 0, 0, "NORTH",  "MOVE", "MOVE" ]
}


{
	"commands": [ "PLACE", 0, 0, "NORTH",  "MOVE", "MOVE", "RIGHT", "MOVE" ]
}

{
	"commands": [ "PLACE", 0, 0, "NORTH",  "MOVE", "MOVE", "RIGHT", "MOVE", "MOVE", "MOVE", "MOVE" ]
}

{
	"commands": [ "PLACE", 0, 0, "NORTH",  "MOVE", "MOVE", "RIGHT", "MOVE", "MOVE", "MOVE", "MOVE", "MOVE" ]
}
