var dw;dw=display_get_gui_width()

if (!global.pause) {
    if ((keyboard_check(vk_tab) || debug_mode || fps_real<global.game_speed*0.95) && is_ingame()) {
        str=string(fps_fast)
        fpsa=min(1.5,fpsa+0.05)
    } else {
        str=string(global.game_speed)
        fpsa=max(0,fpsa-0.05)
    }
    if (fpsa>0.5) {
        for (i=0;i<string_length(str);i+=1)
            draw_sprite_ext(sprFraps,string_pos(string_char_at(str,i+1),"0123456789")-1,32+4+20*i,32+4,1,1,0,$ffffff,fpsa-0.5)
    }
}

//draw debug overlays

if (global.test_run && !is_ingame()) {
    draw_set_halign(1)
    draw_set_font(fntFileSmall)
    draw_text_outline(dw/2,40,"TEST MODE",$ff)
    draw_set_halign(0)
}

if (global.debug_overlay) {
    draw_set_color(c_black)
    draw_set_font(fntFileSmall)

    str=""
    if (instance_exists(Player)) {
        str="X: "+string(Player.x)+" (align "+string(Player.x mod 3)+")#"
           +"Y: "+string(Player.y)+"#"
    }

    str+="Room: "+room_get_name(room)+" ("+string(room)+")#"
    str+="Inst: "+string(instance_count)+"#"

    if (!instance_exists(global.profiler_manager)) {
        str+="FPS: "+string(fps_fast)+"/"+string(room_speed)+" (real "+string(fps_real)+")#"
            +"CPU: "+string(cpu_usage)+"%#"
            +"RAM: "+string(ram_usage/1024/1024)+"MB#"
    }

    str+=string_repeat("God mode#",global.debug_god)
        +string_repeat("Inf jump#",global.debug_jump)

    var c;c=0
    for (i=0;i<100;i+=1) if (surface_exists(i)) c+=1
    if (c==100) str+="ALERT: too many surfaces!"
    else str+=strong(c," surface",string_repeat("s",c!=1),"#")

    draw_text_outline(40,40,str,$ffff)
}

if (message) {
    draw_set_font(fntFileSmall)
    draw_set_alpha(min(1,message/100))
    draw_text_outline(40,40,messagetext,$ffff)
    draw_set_alpha(1)
}
if (message2) {
    draw_set_font(fntFileSmall)
    draw_set_halign(2)
    draw_set_alpha(min(1,message2/100))
    draw_text_outline(dw-40,40,message2text,$ffff)
    draw_set_halign(0)
    draw_set_alpha(1)
}

if (settings("fullscreen") && !global.pause && is_ingame()) {
    if (instance_exists(Player)) {
        if (abs(Player.y-view_yview)<48) caption_opacity=max(1/8,caption_opacity-(1/8)*dt)
        else caption_opacity=min(1,caption_opacity+(1/8)*dt)
        draw_set_alpha(caption_opacity)
    }
    draw_set_font(fntSignpost)
    draw_text_outline(8,8,room_caption,$ffff)
    draw_set_alpha(1)
}