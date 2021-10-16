extends Node2D

var perkFile = load("res://scripts/perks/perk_handler.gd")
var p
var enemyFile = load("res://scripts/enemy.gd")
var enemy

func _ready():
	new_enemy()
	update_stats()
	var perks = you.get_perks()
	
	perk_info.make_choice()

func update_stats():
	$C1/TB/LXP.set_text("XP: " + String(stats.xp))
	$C1/TB/LG.set_text("Gold: " + String(stats.gold))
	$C1/TB/LS.set_text("Streak: " + String(you.streak))
	update_hp()
	$C1/CInv/CCInv/Inv.fill()
	update_chat()

func update_hp():
	$C1/CInv/CHP/PBHP.max_value = you.hp
	$C1/CInv/CHP/PBHP.value = you.current_hp
	var healthText = String(round(you.get_hp())) + "/" + String(you.hp)
	if(you.current_shield > 0):
		healthText += " + "
		healthText += String(round(you.get_shield()))
	$C1/CInv/CHP/LHP.set_text(healthText)
	
	$C1/CEnemy/CeHP/PBeHP.max_value = enemy.hp
	$C1/CEnemy/CeHP/PBeHP.value = enemy.current_hp
	$C1/CEnemy/CeHP/LeHP.set_text(String(round(enemy.get_hp())) + "/" + String(enemy.hp))

func update_chat():
	$C1/CChF/Lchat.set_text(chat.make_chat())

func new_enemy():
	enemy = enemyFile.new()
	enemy.create_empty_inv()
	enemy.add_to_inv(item_creator.default_sword())
	enemy.random_hp()
	
#	random image
	var e1 = preload("res://icons/enemy1.png")
	var e2 = preload("res://icons/enemy2.png")
	var e3 = preload("res://icons/enemy3.png")
	var e4 = preload("res://icons/enemy4.png")
	var e5 = preload("res://icons/enemy5.png")
	var earray = [e1, e2, e3, e4, e5]
	var eimg = earray[randi() % earray.size()]
	var sprite = $C1/CEnemy/CEnemy/Enemy
	sprite.texture = eimg
	
	update_hp()

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		_on_BAtk_pressed()

func _on_BAtk_pressed():
	#check if weapon is insta use or not
	var your_turn = true
	if(you.get_inv_slot(you.get_selected()).takes_turn):
		your_turn = false
	#you attack enemy
	atk(you, enemy, you.get_inv_slot(you.get_selected()))
	if(isDead(enemy)):
		chat.kill_msg(you.kill())
		update_chat()
		enemy.death()
		new_enemy()
	else:
		if(!your_turn):
			#enemy attacks you
			atk(enemy, you, enemy.get_inv_slot(0))
	if(isDead(you)):
		you.death()
#	use potion effects
	effect_handler.turn(you)
	update_stats()

#atk(attacker, defender, weapon)
func atk(a, b, w):
	var heal = load("res://scripts/items/heal.gd")
	#shield takes dmg before hp
	if(b.current_shield > 0):
		b.current_shield -= outputdmgcalc(a, b, inputdmgcalc(a, b, w))
		if(b.current_shield < 0):
			b.current_shield = 0
	else:
		b.current_hp -= outputdmgcalc(a, b, inputdmgcalc(a ,b ,w))
	#if "weapon" is a healing item, use it
	if(w.get_script() == heal):
		w.use_on(a)

#calculate dmg based on weapon dmg and persons multipliers
func inputdmgcalc(a, b, w):
	p = perkFile.new()
	var dmg = w.get_damage()
#	weapon base dmg perks
	dmg = p.offensive_one(a, b, dmg)
#	weapon multi perks
	dmg = p.offensive_two(a, b, dmg)
#	dmg boost shop upgrade
	var dict = a.get_upgrades()
	var boost = 1 + dict["dmgboost"]/100
	dmg = dmg * boost
	return dmg

#calculate dmg based on input dmg and persons armor
func outputdmgcalc(a, b, d):
	p = perkFile.new()
	var armor = b.get_armor()
#	armor base def
	armor = p.defensive_one(a, b, armor)
#	armor def multi
	armor = p.defensive_two(a, b, armor)
#	calculate dmg taken
	for n in range(armor):
		d = d * 0.99
#	armor true def
	d = p.defensive_three(a, b, d)
#	megastreak true dmg
	d = d + b.mtd
	return d

#check if guy is dead
func isDead(who):
	if (who.get_hp() + who.get_shield() <= 0):
		return true
	else:
		return false
