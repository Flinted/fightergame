@player = {
   name: "player 1",
   wins: 0
 }

@player_stats = {
  type: 0,
  health: 0,
  strength: 0,
  toughness: 0,
  speed: 0
}

@opponent = {
  name: "player 2",
  health: 0,
  strength: 0,
  toughness: 0,
  speed: 0
}

@fighters = [
{
name: "All Rounder",
health: 350,
strength: 50,
toughness: 50,
speed: 5 
},
{
name: "FatMan",
health: 600,
strength: 40,
toughness: 50,
speed: 1 
},
{
name: "Muscle Man",
health: 350,
strength: 60,
toughness: 40,
speed: 2
},
{
name: "Fast Man",
health: 300,
strength: 40,
toughness: 40,
speed: 8
},
{
name: "Tough Guy",
health: 350,
strength: 40,
toughness: 55,
speed: 3
},
{
name: "BIG BOSS",
health: 750,
strength: 70,
toughness: 70,
speed: 5
}
]

@attacks = {
  punch:{
    name: "punch",
    type: :high,
    min: 30,
    max: 50
},
  elbow:{
    name: "elbow",
    type: :high,
    min: 10,
    max: 90
},
  throw:{
    name: "throw",
    type: :high,
    min: 40,
    max: 40
},
  kick:{
    name: "kick",
    type: :low,
    min: 30,
    max: 60
},
  knee:{
    name: "knee",
    type: :low,
    min: 10,
    max: 80
},
  sweep:{
    name: "sweep",
    type: :low,
    min: 40,
    max: 40
},
  block_high:{
    name: "block high",
    type: :highblock,
    min: 0,
    max: 0
},
block_low:{
    name: "block low",
    type: :lowblock,
    min: 0,
    max: 0
},
recover:{
    name: "recover",
    type: :heal,
    min: 0,
    max: 75
}
}

def get_player_name()
  @player[:name]
end

def update_player_name(new_name)
  @player[:name] = new_name
end

def choose_fighter(fighter_ref) 
  if fighter_ref <6 && fighter_ref >0
    fighter_ref -= 1
    @player_stats[:type] = @fighters[fighter_ref][:name]
    @player_stats[:health] = @fighters[fighter_ref][:health]
    @player_stats[:strength] = @fighters[fighter_ref][:strength]
    @player_stats[:toughness] = @fighters[fighter_ref][:toughness]
    @player_stats[:speed] = @fighters[fighter_ref][:speed]
  end
end

def choose_opponent()
  fighter_ref = rand(0..5)
  @opponent[:name] = @fighters[fighter_ref][:name]
  @opponent[:health] = @fighters[fighter_ref][:health]
  @opponent[:strength] = @fighters[fighter_ref][:strength]
  @opponent[:toughness] = @fighters[fighter_ref][:toughness]
  @opponent[:speed] = @fighters[fighter_ref][:speed]
end

def choose_attack(attack_ref)
  case attack_ref
  when 1
    return @attacks[:punch]
  when 2
    return @attacks[:elbow]
  when 3
    return @attacks[:throw]
  when 4
    return @attacks[:kick]
  when 5
    return @attacks[:knee]
  when 6
    return @attacks[:sweep]
  when 7
    return @attacks[:block_high]
  when 8
    return @attacks[:block_low]
  when 9
    return @attacks[:recover]
  else
    return @attacks[:stumble]
  end
end

def choose_opponent_attack()
  if @opponent[:health] < 150 && @player_stats[:health] > 150
    return @attacks[:recover]
  else
  
    attack_ref = rand(0..8)
    case attack_ref
      when 1
        return @attacks[:punch]
      when 2
        return @attacks[:elbow]
      when 3
        return @attacks[:throw]
      when 4
        return @attacks[:kick]
      when 5
        return @attacks[:knee]
      when 6
        return @attacks[:sweep]
      when 7
        return @attacks[:block_high]
      when 8
        return @attacks[:block_low]
      else
        return @attacks[:punch]
    end
  end
end

def calculate_player_damage(attack_ref, heal_amount)
  if attack_ref[:type] == :heal
    @player_stats[:health] += heal_amount
    return 0
  elsif (attack_ref[:type] == :lowblock) || (attack_ref[:type] == :highblock)
    return 0
  else
    damage =(@player_stats[:strength] + rand(attack_ref[:max].to_i) +attack_ref[:min].to_i)- @opponent[:toughness]
  end
  return damage
end

def calculate_opponent_damage(attack_ref, heal_amount)
  if attack_ref[:type] == :heal
    @opponent[:health] += heal_amount
    return 0
  elsif (attack_ref[:type] == :lowblock) || (attack_ref[:type] == :highblock)
    return 0
  else
    damage = (@opponent[:strength] + rand(attack_ref[:max].to_i) + attack_ref[:min].to_i) - @player_stats[:toughness]
  end
  return damage
end

def check_player_dodge()
  return true if @player_stats[:speed] * 3 > rand(0..100)
end

def check_opponent_dodge()
  return true if @opponent[:speed] * 3 > rand(0..100)
end

def player_attack(chosen_attack, dodge_success)
  if dodge_success == true
    return 0
  else
    calculate_player_damage(chosen_attack, @player_heal_amount)
  end
end

def opponent_attack(chosen_attack, dodge_success)
  if dodge_success == true
    return 0
  else
    calculate_opponent_damage(chosen_attack, @opponent_heal_amount)
  end
end

def attack_menu_display()
puts "HIGH attacks"
puts "1:PUNCH:  #{@attacks[:punch][:min]} to  #{@attacks[:punch][:max]} base damage."
puts "2:ELBOW:  #{@attacks[:elbow][:min]} to  #{@attacks[:elbow][:max]} base damage."
puts "3:THROW:  #{@attacks[:throw][:min]} to  #{@attacks[:throw][:max]} base damage."
puts
puts "LOW attacks"
puts "4:KICK:  #{@attacks[:kick][:min]} to  #{@attacks[:kick][:max]} base damage."
puts "5:KNEE:  #{@attacks[:knee][:min]} to  #{@attacks[:knee][:max]} base damage."
puts "6:SWEEP: #{@attacks[:sweep][:min]} to  #{@attacks[:sweep][:max]} base damage."
puts
puts "OTHER MOVES"
puts "7:BLOCK HIGH: take no damage and reflect 150% of damage if opponent attacks high"
puts "8:BLOCK LOW:  take no damage and reflect 150% of damage if opponent attacks low"
puts "9:RECOVER: #{@attacks[:recover][:min]} to  #{@attacks[:recover][:max]} is healed."
puts
end

def display_rules()
puts <<-rul
  RULES:
  Health:     how much damage you can take
  Strength:   how much extra damage you can cause on top of base damage
  Toughness:  how much damage you can ignore before losing health
  Speed:      affects how likely you are to dodge an attack completely

  Punch:      low damage but reliable range of damage
  Elbow:      potential high damage but long range
  Throw:      set level of base damage  

  Kick:      low damage but reliable range of damage
  Knee:      potential high damage but long range
  Sweep:     set level of base damage 

  Block:     negates opponent attack if on same level and reflects 150% back   
  Recover:   recovers health but does not attack        
rul
end
def check_fight_order()
  if @player_stats[:speed] > @opponent[:speed]
    return @player[:name] 
  elsif @player_stats[:speed] = @opponent[:speed]
    if rand(0..1) == 0
      return @player[:name]
    else
      return @opponent[:name]
    end
  else
  return @opponent[:name]
  end
end

def update_player_health(dmg_rcvd)
  @player_stats[:health] -= dmg_rcvd.round(1)
  @opponent_win = true if @player_stats[:health] < 1
end

def update_opponent_health(dmg_rcvd)
  @opponent[:health] -= dmg_rcvd.round(1)
  @player_win = true if @opponent[:health] < 1
end

def check_player_block(chosen_attack, other_attack)
  if (chosen_attack[:type] == :lowblock && other_attack[:type] == :low) || (chosen_attack[:type] == :highblock && other_attack[:type] == :high)
    @opponent_damage_rcvd = @player_damage_rcvd * 1.5 
    @player_damage_rcvd = 0
  end
end

def check_opponent_block(chosen_attack, other_attack)
  if (chosen_attack[:type] == :lowblock && other_attack[:type] == :low) || (chosen_attack[:type] == :highblock && other_attack[:type] == :high)
    @player_damage_rcvd = @opponent_damage_rcvd * 1.5 
    @opponent_damage_rcvd = 0
  end
end
#______________________________________________________

system("clear")
puts <<-logo

d8888b. db    db d8b   db  .o88b. db   db 
88  `8D 88    88 888o  88 d8P  Y8 88   88 
88oodD' 88    88 88V8o 88 8P      88ooo88 
88~~~   88    88 88 V8o88 8b      88~~~88 
88      88b  d88 88  V888 Y8b  d8 88   88 
88      ~Y8888P' VP   V8P  `Y88P' YP   YP 
                                          
                                          
    db   dD d888888b  .o88b. db   dD 
    88 ,8P'   `88'   d8P  Y8 88 ,8P' 
    88,8P      88    8P      88,8P   
    88`8b      88    8b      88`8b   
    88 `88.   .88.   Y8b  d8 88 `88. 
    YP   YD Y888888P  `Y88P' YP   YD 
                                     
                                     
   d88888b  .d8b.   .o88b. d88888b db 
   88'     d8' `8b d8P  Y8 88'     88 
   88ooo   88ooo88 8P      88ooooo YP 
   88~~~   88~~~88 8b      88~~~~~    
   88      88   88 Y8b  d8 88.     db 
   YP      YP   YP  `Y88P' Y88888P YP
logo
puts
puts "Would you like to see the rules? Y/N?"
if gets.chomp.upcase == "Y"
  display_rules()
end
puts"--------------------------"
puts "What is your Player Name!"
puts
print ">>"
update_player_name(gets.chomp)
puts
puts "Hello #{get_player_name()}, please select your fighter! [1-5]"
puts
puts "1:The All Rounder: Health #{@fighters[0][:health]}, Strengh #{@fighters[0][:strength]}, Toughness #{@fighters[0][:toughness]}, Speed #{@fighters[0][:speed]}. "
puts "2:The FATMAN:      Health #{@fighters[1][:health]}, Strengh #{@fighters[1][:strength]}, Toughness #{@fighters[1][:toughness]}, Speed #{@fighters[1][:speed]}. "
puts "3:The Muscle Man:  Health #{@fighters[2][:health]}, Strengh #{@fighters[2][:strength]}, Toughness #{@fighters[2][:toughness]}, Speed #{@fighters[2][:speed]}. "
puts "4:The Fast Man:    Health #{@fighters[3][:health]}, Strengh #{@fighters[3][:strength]}, Toughness #{@fighters[3][:toughness]}, Speed #{@fighters[3][:speed]}. "
puts "5:The Tough Guy:   Health #{@fighters[4][:health]}, Strengh #{@fighters[4][:strength]}, Toughness #{@fighters[4][:toughness]}, Speed #{@fighters[4][:speed]}. "
puts
puts
print ">>"
choice = gets.chomp.to_i
if choice < 6
choose_fighter(choice)
end

system("clear")
puts "You chose #{@player_stats[:type]}, Health #{@player_stats[:health]}, Strengh #{@player_stats[:strength]}, Toughness #{@player_stats[:toughness]}, Speed #{@player_stats[:speed]}." 
puts
puts
puts "you are fighting..."
puts
puts
choose_opponent()
puts "#{@opponent[:name]}, Health #{@opponent[:health]}, Strengh #{@opponent[:strength]}, Toughness #{@opponent[:toughness]}, Speed #{@opponent[:speed]}." 
puts

@player_win = false
@opponent_win = false
round_count = 0

while (@player_win == false) && (@opponent_win == false)
round_count += 1
  
  puts
  puts
  puts
  puts
  puts "Please select your attack!"
  puts
  attack_menu_display()

  print ">>" 

  @player_heal_amount = rand(75)
  @opponent_heal_amount = rand(75)
  player_chosen_attack = choose_attack(gets.chomp.to_i)
  opponent_chosen_attack = choose_opponent_attack()
  player_dodge = check_player_dodge()
  opponent_dodge = check_opponent_dodge()
  @player_damage_rcvd = opponent_attack(opponent_chosen_attack, player_dodge)
  @opponent_damage_rcvd = player_attack(player_chosen_attack, opponent_dodge)

  system('clear')

  initiative = check_fight_order()
    puts
    puts
  if @player[:name] == initiative
    puts "#{@player[:name]} hits first... he chose to #{player_chosen_attack[:name]}!"
    puts
    puts
    puts "#{@opponent[:name]} hits second... he chose to #{opponent_chosen_attack[:name]}!"
    puts 
  else
    puts "#{@opponent[:name]} hits first... he chose to #{opponent_chosen_attack[:name]}!"
    puts 
    puts
    puts "#{@player[:name]} hits second... he chose to #{player_chosen_attack[:name]}!"
    puts
  end

  check_player_block( player_chosen_attack, opponent_chosen_attack )
  check_opponent_block( opponent_chosen_attack, player_chosen_attack )
  sleep 1
    puts
  if player_dodge
    puts "#{@player[:name]} Dodges!"
  end

  if opponent_dodge
    puts "#{@opponent[:name]} Dodges!"
  end
    puts
  if @player[:name] == initiative
    puts "#{@player[:name]} attacks! His #{player_chosen_attack[:name]} does #{@opponent_damage_rcvd}"
    update_opponent_health(@opponent_damage_rcvd)
    sleep 1
    puts
    puts "#{@opponent[:name]} attacks! His #{opponent_chosen_attack[:name]} does #{@player_damage_rcvd}"
    update_player_health(@player_damage_rcvd)
  else
    puts "#{@opponent[:name]} attacks! His #{opponent_chosen_attack[:name]} does #{@player_damage_rcvd}"
    update_player_health(@player_damage_rcvd)
    sleep 1
    puts 
    puts "#{@player[:name]} attacks! His #{player_chosen_attack[:name]} does #{@opponent_damage_rcvd}"
    update_opponent_health(@opponent_damage_rcvd)
    puts
  end
    puts
    puts
  if player_chosen_attack[:type] == :heal
    puts "#{@player[:name]} recovers for #{@player_heal_amount}."
  end
  puts
  if opponent_chosen_attack[:type] == :heal
    puts "#{@opponent[:name]} recovers for #{@opponent_heal_amount}."
  end

  sleep 1
  puts 
  puts
  puts "#{@player[:name]} health: #{@player_stats[:health]}."
  puts "#{@opponent[:name]} health: #{@opponent[:health]}." 
  
end
puts
puts
  if @player_win == true && @opponent_win == true
    puts <<-dko
    d8888b. d8888b. db        db   dD  .d88b.  db 
    88  `8D 88  `8D 88        88 ,8P' .8P  Y8. 88 
    88   88 88oooY' 88        88,8P   88    88 YP 
    88   88 88~~~b. 88        88`8b   88    88    
    88  .8D 88   8D 88booo.   88 `88. `8b  d8' db 
    Y8888D' Y8888P' Y88888P   YP   YD  `Y88P'  YP
    dko
  elsif @player_win == true
    puts 
puts <<-win
    db    db  .d88b.  db    db 
    `8b  d8' .8P  Y8. 88    88 
     `8bd8'  88    88 88    88 
       88    88    88 88    88 
       88    `8b  d8' 88b  d88 
       YP     `Y88P'  ~Y8888P' 
                               
                               
db   d8b   db d888888b d8b   db db 
88   I8I   88   `88'   888o  88 88 
88   I8I   88    88    88V8o 88 YP 
Y8   I8I   88    88    88 V8o88    
`8b d8'8b d8'   .88.   88  V888 db 
 `8b8' `8d8'  Y888888P VP   V8P YP 
 win

  else
puts <<-lose
        db    db  .d88b.  db    db 
        `8b  d8' .8P  Y8. 88    88 
         `8bd8'  88    88 88    88 
           88    88    88 88    88 
           88    `8b  d8' 88b  d88 
           YP     `Y88P'  ~Y8888P' 
                                   
                                   
    db       .d88b.  .d8888. d88888b db 
    88      .8P  Y8. 88'  YP 88'     88 
    88      88    88 `8bo.   88ooooo YP 
    88      88    88   `Y8b. 88~~~~~    
    88booo. `8b  d8' db   8D 88.     db 
    Y88888P  `Y88P'  `8888Y' Y88888P YP
lose
    
  end
puts
puts
puts "in #{round_count} rounds!"

