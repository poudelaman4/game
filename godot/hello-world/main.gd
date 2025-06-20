extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var real="ama"
	prints("checking if my word",real,"is a palindrome word")
	#We need to create a reverse word and check if these two are equal for palindrome check
	var reverse = ""
	for i in range(real.length()-1,-1,-1):# real.length()-->2 range(start,end,step)-->start==0 ,1,2,3 ,,end=-1 
		var character = real[i]		# for making start -1 , start=0 in array so 0-1 --> real.length() -1 
		reverse += character		# then our end is -1 and step too -1 at a time like 1 to -1 then
	if (real== reverse):			#goes -1,-2==0 and -3==-1which is terminated by for logic 
		prints("my word",real,"is palindrome")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
