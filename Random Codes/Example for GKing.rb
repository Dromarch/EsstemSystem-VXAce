class Scene_Map < Scene_Base
  
    alias :ex_start :start
    def start
      ex_start
      @infos = My_Window.new(0, 0, 200, 100)
    end
    
    alias new_update update
    def update
      new_update
      change_character if Input.trigger?(:C)
    end
    
    def change_character
      Sound.play_ok
      $game_party.swap_order($game_party.leader.index, $game_party.members[1].index)
      @infos.refresh
    end
    
  end
   
  class My_Window < Window_Base
    
    def initialize(x, y, width, height)
      super(x, y, width, height)
      self.opacity = 50
    end
    
    def update
      super
      @actor1 = $game_party.leader
      if @actor1.hp != @hp || @actor1.mp != @mp
        refresh
      end
    end
    
    def refresh
      self.contents.clear
      self.draw_character(@actor1.character_name, @actor1.character_index, 16, 32)
      self.draw_actor_hp(@actor1, 42, 16)
      self.draw_actor_mp(@actor1, 42, 42)
      @hp = @actor1.hp
      @mp = @actor1.mp
    end
    
  end