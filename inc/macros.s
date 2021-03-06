#-----------------------------------------------------------------------
# macros.s
#-----------------------------------------------------------------------
#File contains general macros used by both sides, such as push and pop

.ifndef MACROS_S
.set MACROS_S, 1

#-----------------------------------------------------------------------
# GENERAL PURPOSE MACROS
#-----------------------------------------------------------------------


/*
-----------------------------------------------------------------------
 HEX2BCD
 Convert hex value to BCD
-----------------------------------------------------------------------
 IN:
  d0 - hex value
 OUT:
  d0 - bcd value
 BREAK:
  d1
-----------------------------------------------------------------------
*/
.macro HEX2BCD
	ext.l	d0
	divu.w	#0xa, d0
	move.b	d0, d1
	lsl.b	#4, d1
	swap	d0
	move	#0, ccr /* why?*/
	abcd	d1, d0
.endm


/*
-----------------------------------------------------------------------
 PUSH
 Push register/value on to stack
-----------------------------------------------------------------------
 IN:
   register name/value
 OUT:
  none
 BREAK:
  none
-----------------------------------------------------------------------
*/
.macro PUSH value
	move.l \value, -(sp)
.endm

/*
-----------------------------------------------------------------------
 POP
 Pop register/value from stack
-----------------------------------------------------------------------
 IN:
   register name/value
 OUT:
  none
 BREAK:
  none
-----------------------------------------------------------------------
*/
.macro POP value
	move.l  (sp)+, \value
.endm

/*
-----------------------------------------------------------------------
 PUSHM
 Saves multiple registers to stack
-----------------------------------------------------------------------
 IN:
   register names
 OUT:
  none
 BREAK:
  none
-----------------------------------------------------------------------
*/
.macro PUSHM registers
	movem.l \registers, -(sp)
.endm

/*
-----------------------------------------------------------------------
 POPM
 Restore specified registers from stack
-----------------------------------------------------------------------
 IN:
   register names
 OUT:
  none
 BREAK:
  none
-----------------------------------------------------------------------
*/
.macro POPM registers
	movem.l (sp)+, \registers
.endm

.endif
