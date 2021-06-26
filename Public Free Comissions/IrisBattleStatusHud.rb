#==============================================================================
# ** Iris Battle Status HUD
#==============================================================================
module IRIS_BATTLESTATUSHUD_SETTINGS
  
  FACE_X_OFFSET = 0  # Coordenada X da face
  FACE_Y_OFFSET = 0  # Coordenada Y da face
  FACE_WIDTH    = 60 # Largura da face
  FACE_HEIGHT   = 96 # Altura da face
  
  NAME_X_OFFSET = 28 # Coordenada X do nome
  NAME_Y_OFFSET = 2  # Coordenada Y do nome
  
  STATUS_X_OFFSET = 2  # Coordenada X dos ícones de status
  STATUS_Y_OFFSET = 2  # Coordenada Y dos ícones de status
  STATUS_TIMER    = 60 # Tempo de atualização dos ícones de status
  
  GAUGES_X_OFFSET = 46 # Coordenada X das barrinhas
  GAUGES_Y_OFFSET = 24 # Coordenada Y das barrinhas
  GAUGES_SPACING  = 24 # Espaçamento entre as barrinhas
  GAUGES_WIDTH    = 76 # Largura das barrinhas
  
  
end # Don't touch here :' D
#==============================================================================
# ** Fim das configurações
#==============================================================================
class Game_Actor < Game_Battler
  
  attr_accessor :status_index
  
  alias iris_ga_initialize initialize
  def initialize(actor_id)
    iris_ga_initialize(actor_id)
    @status_index = 0
  end
  
end
class Window_BattleStatus < Window_Selectable
  include IRIS_BATTLESTATUSHUD_SETTINGS
  
  def col_max
    return 3
  end
  
  def item_height
    (height - standard_padding * 2)
  end
  
  def spacing
    return 4
  end
  
  def item_rect_for_text(index)
    rect = item_rect(index)
    rect
  end
  
  def draw_basic_area(rect, actor)
    draw_actor_face(actor, rect.x + 1 + FACE_X_OFFSET, rect.y + 1 + FACE_Y_OFFSET, true)
    draw_actor_name(actor, rect.x + NAME_X_OFFSET, rect.y + NAME_Y_OFFSET, 100)
    draw_actor_icons(actor, rect.x + STATUS_X_OFFSET, rect.y + STATUS_Y_OFFSET, rect.width)
  end
  
  def draw_face(face_name, face_index, x, y, enabled = true)
    bitmap = Cache.face(face_name)
    width = FACE_WIDTH
    height = FACE_HEIGHT
    rect = Rect.new((face_index % 4 * 96) + (width / 2), face_index / 4 * 96, width, height - 2)
    contents.blt(x, y, bitmap, rect, enabled ? 255 : translucent_alpha)
    bitmap.dispose
  end
  
  def draw_actor_icons(actor, x, y, width = 96)
    icons = (actor.state_icons + actor.buff_icons)
    return unless icons.length > 0
    actor.status_index = 0 if actor.status_index > icons.length - 1
    id = actor.status_index
    draw_icon(icons[id], x, y)
  end
  
  def gauge_area_rect(index)
    rect = item_rect_for_text(index)
    rect.x += GAUGES_X_OFFSET
    rect.y += GAUGES_Y_OFFSET
    rect.width = gauge_area_width
    rect
  end
  
  def draw_gauge_area_with_tp(rect, actor)
    spacing = GAUGES_SPACING
    width = GAUGES_WIDTH
    draw_actor_hp(actor, rect.x, rect.y, width)
    rect.y += spacing
    draw_actor_mp(actor, rect.x, rect.y, width)
    rect.y += spacing
    draw_actor_tp(actor, rect.x, rect.y, width)
  end
  
end
class Scene_Battle < Scene_Base
  
  alias iris_sb_start start
  def start
    iris_sb_start
    @timer = 0
  end
  
  alias iris_sb_update update
  def update
    iris_sb_update
    @timer += 1
    if @timer > STATUS_TIMER
      $game_party.battle_members.each do |actor|
        actor.status_index += 1
      end
      @status_window.refresh
      @actor_window.refresh
      @timer = 0
    end
  end
  
end