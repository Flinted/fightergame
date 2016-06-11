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
speed: 4, 
},
{
name: "FatMan",
health: 500,
strength: 40,
toughness: 50,
speed: 1, 
},
{
name: "Muscle Man",
health: 350,
strength: 70,
toughness: 40,
speed: 3, 
},
{
name: "Fast Man",
health: 300,
strength: 50,
toughness: 30,
speed: 5, 
},
{
name: "Tough Man",
health: 350,
strength: 50,
toughness: 50,
speed: 4, 
}
]

@attacks = [
  punch:{
    type: :high,
    min: 30,
    max: 50,
},
  elbow:{
    type: :high,
    min: 10,
    max: 90,
},
  throw:{
    type: :high,
    min: 40,
    max: 40,
},
kick:{
    type: :low,
    min: 30,
    max: 60,
},
knee:{
    type: :low,
    min: 10,
    max: 80,
},
sweep:{
    type: :low,
    min: 40,
    max: 40,
},
block_high:{
    type: :high,
    min: 30,
    max: 50,
},
block_low:{
    type: :low,
    min: 30,
    max: 50,
},
recover:{
    type: :heal,
    min: 30,
    max: 50,
}]

def get_player_name()
  @player[:name]
end

def update_player_name(new_name)
  @player[:name] = new_name
end

def choose_fighter(fighter_ref) 
if fighter_ref < 5 && fighter_ref > 0
  fighter_ref -= 1
  @player_stats[:type] = @fighters[fighter_ref][:name]
  @player_stats[:health] = @fighters[fighter_ref][:health]
  @player_stats[:strength] = @fighters[fighter_ref][:strength]
  @player_stats[:toughness] = @fighters[fighter_ref][:toughness]
  @player_stats[:speed] = @fighters[fighter_ref][:speed]
end
end

def choose_opponent()
  fighter_ref = rand(0..4)
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
  when 9
    return @attacks[:recover]
  else
    return @attacks[:stumble]
  end
end

def calculate_player_damage(attack_ref)
  if attack_ref[:type] = :heal
    damage = -rand(30..75)
  else
    damage =@player_stats[:strength] + rand(attack_ref[:min], attack_ref[:max]) - @opponent[:toughness]
  end
  return damage
end

def calculate_opponent_damage(attack_ref)
  if @opponent[:health] < 150
    damage = -rand(30..75)
  else
    damage =@player_stats[:strength] + rand(attack_ref[:min], attack_ref[:max]) - @opponent[:toughness]
  end
  return damage
end
system("clear")
puts "WELCOME TO THE FIGHT CLUB"
puts
puts "What is your Player Name!"
print ">>"
update_player_name(gets.chomp)
puts "Hello #{get_player_name()}, please select your fighter! [1-5]"
puts "1:The All Rounder: Health #{@fighters[0][:health]}, Strengh #{@fighters[0][:strength]}, Toughness #{@fighters[0][:toughness]}, Speed #{@fighters[0][:speed]}. "
puts "2:The FATMAN:      Health #{@fighters[1][:health]}, Strengh #{@fighters[1][:strength]}, Toughness #{@fighters[1][:toughness]}, Speed #{@fighters[1][:speed]}. "
puts "3:The Muscle Man:  Health #{@fighters[2][:health]}, Strengh #{@fighters[2][:strength]}, Toughness #{@fighters[2][:toughness]}, Speed #{@fighters[2][:speed]}. "
puts "4:The Fast Man:    Health #{@fighters[3][:health]}, Strengh #{@fighters[3][:strength]}, Toughness #{@fighters[3][:toughness]}, Speed #{@fighters[3][:speed]}. "
puts "5:The Tough Guy:   Health #{@fighters[4][:health]}, Strengh #{@fighters[4][:strength]}, Toughness #{@fighters[4][:toughness]}, Speed #{@fighters[4][:speed]}. "
puts "6: Quit Game. "
print ">>"
choice = gets.chomp.to_i
if choice < 5
choose_fighter(choice)
else
"Goodbye"
end

puts "You chose #{@player_stats[:type]}, Health #{@player_stats[:health]}, Strengh #{@player_stats[:strength]}, Toughness #{@player_stats[:toughness]}, Speed #{@player_stats[:speed]}." 
sleep 1
puts "you are fighting..."
choose_opponent()
puts "#{@opponent[:type]}, Health #{@opponent[0][:health]}, Strengh #{@opponent[0][:strength]}, Toughness #{@opponent[0][:toughness]}, Speed #{@opponent[0][:speed]}." 


