extends Node2D

var perkFile = load("res://code/perks/perk_handler.gd")
var p
var enemyFile = load("res://code/player/enemy.gd")
var enemy : enemy_file
var can_attack := true
var rng = RandomNumberGenerator.new()

func _ready():
	new_enemy()
	update_stats()
	in_signals()
	rng.randomize()

func update_stats():
	$C1/CInv/CCInv/Inv.fill()

func new_enemy():
	enemy = enemyFile.new()
	enemy.create_empty_inv()
	enemy.add_to_inv(item_creator.default_sword())
	enemy.random_hp()
	out_signals()
	if rng.randi_range(1, 20) == 1 and you.streak > 5:
		enemy.strong()
	
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
		chat.kill_msg(you.kill(enemy.bounty))
		enemy.death() 

	#enemy attacks you
	else:
		if(!your_turn):
			atk(enemy, you, enemy.get_inv_slot(0))

#	tick potion effects
	effect_handler.turn(enemy)
	effect_handler.turn(you)

	if(isDead(you)):
		scene_handler.deathscreen()
	
	get_tree().call_group("crit_marker", "queue_free")
	if you.next_crit:
		add_crit_mark()
	
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
	
	var dmg
	
#BASE
	p = perk_handler
	a.base = w.get_damage()
#	weakness potions effect
	for e in a.effects:
		if e.get_name() == "weakness":
			a.base -= e.get_level()
#	megastreak other persons extra base dmg taken
	a.base += b.md
#	weapon base dmg perks
	a.base = p.calc_base(a, b, a.base)
	
	dmg = a.base

#MULTIPLIER
#	weapon multi perks
	a.mult = p.calc_mult(a, b, a.mult)
#	dmg boost shop upgrade
	var dict = a.upgrades
	var boost = 1 + dict["dmgboost"]/100
	a.mult = a.mult * boost
#	megastreak dmg boost
	a.mult = a.mult * (a.mdb + 1)
#	Crit
	if a.crit == true:
		a.mult = a.mult * a.crit_mult / 100
	
	dmg *= a.mult / 100

#CRIT CHANCE
	p.calc_cc(a, b)

#DEFENCE
#	armor base def
	b.armor = p.calc_armor(a, b, b.armor)
#	armor def multi
	b.armor = p.defensive_two(a, b, b.armor)
#	resistance effect
	for e in b.effects:
		if e.get_name() == "res":
			b.armor += (e.get_level() * 10)
#	calculate dmg taken
	for n in range(b.armor):
		dmg *= 0.99

#TRUE
#	weapon true perks (healing/true dmg)
	a.tru = p.calc_tru(a, b, a.tru)
#	armor true def
	a.tru = p.defensive_three(a, b, a.tru)
#	megastreak true dmg
	a.tru = a.tru + b.mtd
	
	dmg += a.tru
	
#	add dmg done to run stats
	if a == you:
		scene_handler.run_dmg += round(dmg)
		if 7 in stats.pUpgrades: #dmg numbers
			var type = "CRIT" if a.crit else "DMG"
			$C1/CEnemy/CEnemy/FCTManager.show_value(dmg, type)
		if rng.randi_range(1, 100) <= you.cc:
			you.next_crit = true
	
	a.reset_fight()
	
	return dmg

#check if guy is dead
func isDead(who):
	if (who.get_hp() + who.get_shield() <= 0):
		return true
	else:
		return false

func in_signals():
	you.connect("health_changed", $C1/CInv/HeartBar,"update_health")
	you.connect("effects_changed", $C1/CChF/EffSContainer, "update_effects")
	enemy.connect("health_changed", $C1/CEnemy/HeartBar ,"update_health")
	enemy.connect("effects_changed", $C1/CEnemy/EffSContainer, "update_effects")
	out_signals()

#output signals for ui
func out_signals():
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
	$C1/CEnemy/CEnemy/Enemy.add_child(mark)
	mark.random_pos(rng.randi_range(-50, 50),rng.randi_range(-100, 100))
	mark.connect("pressed", self, "crit_pressed")
	you.next_crit = false

func _on_bounty_timer_timeout():
	if enemy.bounty > 0:
		$C1/CEnemy/CEnemy/FCTManager.show_value(enemy.bounty, "G")
