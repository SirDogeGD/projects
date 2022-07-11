extends Node2D

var perkFile = load("res://code/perks/perk_handler.gd")
var p
var enemyFile = load("res://code/player/enemy.gd")
var enemy : enemy
var can_attack := true

func _ready():
	new_enemy()
	update_stats()
	in_signals()
	add_crit_mark()

func update_stats():
	$C1/CInv/CCInv/Inv.fill()

func new_enemy():
	enemy = enemyFile.new()
	enemy.create_empty_inv()
	enemy.add_to_inv(item_creator.default_sword())
	enemy.random_hp()
	
#	random image
	var e1 = preload("res://icons/enemy/enemy1.png")
	var e2 = preload("res://icons/enemy/enemy2.png")
	var e3 = preload("res://icons/enemy/enemy3.png")
	var e4 = preload("res://icons/enemy/enemy4.png")
	var e5 = preload("res://icons/enemy/enemy5.png")
	var earray = [e1, e2, e3, e4, e5]
	var eimg = earray[randi() % earray.size()]
	var sprite = $C1/CEnemy/CEnemy/Enemy
	sprite.texture = eimg

#check for attack input
func _on_CEnemy_gui_input(event):
	if event.is_action_pressed("attack") and can_attack:
		_on_BAtk_pressed()

func _on_BAtk_pressed():
	can_attack = false
	#check if weapon is insta use or not
	var your_turn = true
	if(you.get_inv_slot(you.get_selected()).takes_turn):
		your_turn = false
	#you attack enemy
	perk_handler.combo += 1
	atk(you, enemy, you.get_inv_slot(you.get_selected()))
	effect_handler.update_effects(you)
	effect_handler.update_effects(enemy)
	$C1/CEnemy/CEnemy/Enemy.modulate = Color(1, 0.5, 0.5)

	if(isDead(enemy)):
		chat.kill_msg(you.kill())
		enemy.death()
		new_enemy()

	#enemy attacks you
	else:
		if(!your_turn):
			atk(enemy, you, enemy.get_inv_slot(0))

#	tick potion effects
	effect_handler.turn(enemy)
	effect_handler.turn(you)

	if(isDead(you)):
		scene_handler.deathscreen()
	
	yield(get_tree().create_timer(0.2), "timeout")
	$C1/CEnemy/CEnemy/Enemy.modulate = Color(1, 1, 1)
	can_attack = true
	update_stats()

#atk(attacker, defender, weapon)
func atk(a : guy, b : guy, w):
	var d = dmg_calc(a, b, w)
	var heal = load("res://code/items/heal.gd")
	#shield takes dmg before hp
	if(b.current_shield > 0):
		b.current_shield -= d
		if(b.current_shield < 0):
			b.current_shield = 0
	else:
		b.current_hp -= d
	
	#if "weapon" is a healing item, use it
	if(w.get_script() == heal):
		w.use_on(a)

#calculate dmg (attacker, defender, weapon)
func dmg_calc(a : guy, b : guy, w):

#BASE
	p = perk_handler
	var dmg = w.get_damage()
#	weakness potions effect
	for e in a.get_effects():
		if e.get_name() == "weakness":
			dmg -= e.get_level()
#	megastreak other persons extra base dmg taken
	dmg += b.md
#	weapon base dmg perks
	dmg = p.offensive_one(a, b, dmg)

#MULTIPLIER
#	weapon multi perks
	dmg = p.offensive_two(a, b, dmg)
#	dmg boost shop upgrade
	var dict = a.get_upgrades()
	var boost = 1 + dict["dmgboost"]/100
	dmg = dmg * boost
#	megastreak dmg boost
	dmg = dmg * (a.mdb + 1)
#	Crit
	if a.crit == true:
		dmg = dmg * a.cd / 100

#DEFENCE
	var armor = b.get_armor()
#	armor base def
	armor = p.defensive_one(a, b, armor)
#	armor def multi
	armor = p.defensive_two(a, b, armor)
#	resistance effect
	for e in b.get_effects():
		if e.get_name() == "res":
			armor += (e.get_level() * 10)
#	calculate dmg taken
	for n in range(armor):
		dmg = dmg * 0.99

#TRUE
#	weapon true perks (healing/true dmg)
	dmg = p.offensive_three(a, b, dmg)
#	armor true def
	dmg = p.defensive_three(a, b, dmg)
#	megastreak true dmg
	dmg = dmg + b.mtd
	
#	add dmg done to run stats
	if a == you:
		scene_handler.run_dmg += round(dmg)
		if 7 in stats.pUpgrades: #dmg numbers
			$C1/CEnemy/CEnemy/FCTManager.show_value(dmg)
	
	return dmg

#check if guy is dead
func isDead(who):
	if (who.get_hp() + who.get_shield() <= 0):
		return true
	else:
		return false

func in_signals():
	you.connect("health_changed", $C1/CInv/HeartBar ,"update_health")
	you.connect("effects_changed", $C1/CChF/EffSContainer, "update_effects")
	enemy.connect("health_changed", $C1/CEnemy/HeartBar ,"update_health")
	enemy.connect("effects_changed", $C1/CEnemy/EffSContainer, "update_effects")
	for e in [you, enemy]:
		e.emit_signal("health_changed", e.current_hp, e.hp, e.current_shield)
		e.emit_signal("effects_changed", e.effects)

func crit_pressed():
	if can_attack:
		you.crit = true
		_on_BAtk_pressed()

func add_crit_mark():
	var markFile = load("res://code/fight/crit/crit.tscn")
	var mark : crit_mark = markFile.instance()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$C1/CEnemy/CEnemy/Enemy.add_child(mark)
	mark.random_pos(rng.randi_range(-50, 50),rng.randi_range(-100, 100))
	mark.connect("pressed", self, "crit_pressed")
