extends Control

func start(speaker):
	if speaker == "MrDog":
		Globalstats.PlayerAnimal1Count = 1
	elif speaker == "MrsCat":
		Globalstats.PlayerAnimal2Count = 1
	print (Globalstats.PlayerAnimal1Count)
	print (Globalstats.PlayerAnimal2Count)
