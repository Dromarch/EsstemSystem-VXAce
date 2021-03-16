class Scene_Title < Scene_Base

    def start
      super
      SceneManager.goto(Scene_LoadBar)
    end
  
    def terminate
      super
    end
  
  end
  
  class Scene_LoadBar < Scene_Base
    
    def start
      super
      @width_ldbar = 0
      draw_barrinha
    end
    
    def draw_barrinha
      @width_ldbar += 1
      @height_ldbar = 25
      @color_ldbar = Color.new(255, 0, 0)
      @loading_bar = Sprite.new
      @loading_bar.bitmap = Bitmap.new(@width_ldbar, @height_ldbar)
      @loading_bar.x = (Graphics.width - 450) / 2
      @loading_bar.y = (Graphics.height - @height_ldbar) / 2
      @loading_bar.z = 999
      @loading_bar.bitmap.fill_rect(0, 0, @width_ldbar, @height_ldbar, @color_ldbar)
    end
  
    def refresh
      @loading_bar.dispose
      draw_barrinha
    end
  
    def update
      super
      if @width_ldbar < 450 ; refresh
      else ; @width_ldbar = 0 ; end
    end
    
  end