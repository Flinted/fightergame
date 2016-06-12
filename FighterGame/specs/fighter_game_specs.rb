require 'minitest/autorun'
require_relative '../fightergame.rb'

class TestFighterGame < Minitest::Test

  def setup
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
    },
    {
    name: "Tough Man",
    health: 350,
    strength: 50,
    toughness: 50,
    speed: 4, 
    }
    ]

    @attacks = {
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
        min: 3,
        max: 50,
    },
    block_low:{
        type: :low,
        min: 0,
        max: 0,
    },
    recover:{
        type: :heal,
        min: 0,
        max: 100,
    }}
  end


  def test_get_player_name()
    name = get_player_name("Chris")
    assert_equal("player 1", name)
  end

  def test_update_player_name()
    update_player_name("Jack")
    assert_equal("Jack",@player[:name])
  end

  def test_choose_fighter()
    choose_fighter(1)
    assert_equal(4, @player_stats[:speed])
  end

  # def test_choose_opponent()
  #   assert_equal(!"player 2", choose_opponent)
  # end

  def test_choose_attack()
    attack = choose_attack(3)
    assert_equal(@attacks[:throw],attack)
  end

  # def test_opponent_attack()
  #   attack = opponent_attack(2)
  #   assert_equal("elbow", attack)
  # end

  # def test_player_damage()
  #   damage = player_damage("all_rounder", "punch")
  #   assert_equal()
  # end


  # def test_opponent_damage()

  # end

  # def test_player_dodge()

  # end

  # def test_opponent_dodge()

  # end

  # def test_players_health()

  # end

  # def test_round_outcome()

  # end
end