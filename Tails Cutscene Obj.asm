Obj_AIZTailsIntro:
		jsr    StarttoSkip_Cutscene
		moveq	#0,d0
		move.b	5(a0),d0
		move.w	Obj_AIZTailsIntroOFF(pc,d0.w),d0
		jmp	Obj_AIZTailsIntroOFF(pc,d0.w)
		
; ---------------------------------------------------------------------------------
Obj_AIZTailsIntroOFF:
		dc.w   Obj_AIZTailsIntroStart-Obj_AIZTailsIntroOFF
		dc.w   Obj_AIZTailsIntroInit-Obj_AIZTailsIntroOFF
		dc.w   Obj_AIZTailsIntroStartLvl-Obj_AIZTailsIntroOFF
		dc.w   Obj_AIZTailsIntroTitleCard-Obj_AIZTailsIntroOFF
		dc.w   Obj_AIZTailsIntroEnd-Obj_AIZTailsIntroOFF
; ---------------------------------------------------------------------------------

Obj_AIZTailsIntroStart:
		addq.b	#2,5(a0)
		move.w	#$280,8(a0)
		move.b	#-$46,$22(a0)
		move.b	#$40,7(a0)
		move.b	#$20,6(a0)
		move.w	#$60,$10(a0)
		move.w	#$50,$14(a0)
		move.w	#$40,$2E(a0)
		move.w	#8,$40(a0)
		clr.w	(Events_fg_1).w
		
Obj_AIZTailsIntroInit:
		addq.b	#2,5(a0)
		move.w	#$300,$18(a0)
		move.w	#$600,$1A(a0)
		move.l  #Obj_TailsPlaneParentInit,(Player_1).w
		sub.w   #$20,(Player_1+y_pos).w
		move.w	#$DE2C,(Player_1+$42).w
		
; ---------------------------------------------------------------------------
		
Obj_AIZTailsIntroEnd:
			rts
			
; ---------------------------------------------------------------------------

Obj_TailsPlaneParentInit:
		move.l	#Map_AIZIntroPlane,$C(a0)
		move.w	#$529,$A(a0)
		move.w	#$280,8(a0)
		move.b	#$40,7(a0)
		move.b	#$20,7(a0)
		jsr	Swing_Setup1(pc)
		lea	(ArtKosM_AIZIntroPlane).l,a1
		move.w	#$A520,d2
		jsr	(Queue_Kos_Module).l
		lea	(ArtKosM_AIZIntroEmeralds).l,a1
		move.w	#$B620,d2
		jsr	 (Queue_Kos_Module).l
		lea     (Tails_tails).w,a1
		move.l  #Obj_TailsPlaneChildMain_Proller,(a1)
		move.l	$C(a0),$C(a1)
		move.l	$A(a0),$A(a1)
		move.w  #$3804,$42(a1)
		move.w	#0,8(a1)
		move.w  #$0100,$22(a1)
		move.b	#4,7(a1)
		move.b	#$C,7(a1)
		move.w	#$B000,$46(a1)
		lea    (Dust_P2).w,a1
		move.l  #Obj_TailsPlaneChildMain_Booster,(a1)
		move.l	$C(a0),$C(a1)
		move.l	$A(a0),$A(a1)
		move.w  #$1818,$42(a1)
		move.w	#$280,8(a1)
		move.w  #$0500,$22(a1)
		move.b	#4,7(a1)
		move.b	#$C,7(a1)
		move.w	a0,$46(a1)
	
Obj_TailsPlaneParentInit_End:
		move.w  #$600,$18(a0)
		move.l	#Obj_TailsPlaneParentMain,(a0)
		rts
		
; ---------------------------------------------------------------------------

Obj_AIZTailsIntroStartLvl:
		cmpi.w	#$1250,(Player_1+$10).w
		bcs.s	Obj_AIZTailsIntroStartLvlEnd
		jsr     Load_TailsAlone
		move.b	#1,(Ctrl_1_locked).w
		move.b  #0,(Player_1+5).w
		move.b  #0,(Dust_P2+5).w
		move.b  #0,(Tails_tails+5).w
		move.w  #$D20,(Player_1+$18).w
		move.w  #-$D50,(Player_1+$1A).w
		move.w  #0,(Player_1+$1C).w	
		move.b  #0,(Tails_tails+$20).w
		move.b  #0,(Tails_tails+$34).w
		move.b  #$1B,(Player_1+$20).w
		bset	#1,(Player_1+$2A).w
		move.b	#1,(Player_1+$40).w
		addq.b	#2,5(a0)
		move.w	#sfx_Crash,d0
		jsr		(Play_SFX).l
		
Obj_AIZTailsIntroStartLvlEnd:		
		rts 
		
; ---------------------------------------------------------------------------

Obj_AIZTailsIntroTitleCard:
		cmpi.w	#$13C0,(Player_1+$10).w
		bcs.s	Obj_AIZTailsIntroStartLvlEnd
		move.b	#0,(Ctrl_1_locked).w
		move.w  #0,(Player_1+$18).w
		move.w  #0,(Player_1+$1A).w
		move.w  #0,(Player_1+$1C).w	
		jmp	(loc_61F22).l
		
; ---------------------------------------------------------------------------

Obj_TailsPlaneParentMain:
		jsr	(Swing_UpAndDown).l
		jsr	(MoveSprite2).l
		jmp	(Draw_Sprite).l
		
; ----------------------------------------------------------------------------

Obj_TailsPlaneChildMain_Proller:
		lea	(byte_67A8F).l,a1
		bra.s  Obj_TailsPlaneChildMain

; ----------------------------------------------------------------------------

Obj_TailsPlaneChildMain_Booster:
		lea	(byte_67A97).l,a1

; ----------------------------------------------------------------------------
		
Obj_TailsPlaneChildMain:		
		jsr	(Animate_RawNoSST).l
		jsr	(Refresh_ChildPosition).l
		jmp	(Draw_Sprite).l
		
; ---------------------------------------------------------------------------
; object ends here 