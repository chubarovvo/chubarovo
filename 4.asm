.include "m16def.inc" ; 
.def temp=r16 ; 
.def x1exp=r18 
.def x1m=r19 
.def x2exp=r20 
.def x2m=r21 
.def x3exp=r22 
.def x3m=r23 
.def x4exp=r24 
.def x4m=r25 
.def x5exp=r26 
.def x5m=r27 
.def Vexp=r28 
.def Vm=r29 
.def Cexp=r30 
.def Cm=r31 
.def Mexp=r32
.def Nexp=r17 
.org 0x0000 ; 
rjmp reset ; 
.org 0x0030 ; 
reset: 
ldi temp,low(RAMEND) ; 
out SPL,TEMP ; 
ldi temp,high(RAMEND) 
out SPH,TEMP 
;----Присвоение значений регистрам-----— 
ldi x1exp,3 
ldi x1m,2 
ldi x2exp,3 
ldi x2m,1 
ldi x3exp,3 
ldi x3m,5 
ldi x4exp,2 
ldi x4m,4 
ldi x5exp,1 
ldi x5m,8 
ldi Nexp,3 
ldi Nm,0  
X3-(X2+X1)=C ЕСЛИ С<0 ТО V=C-X4+X5, ЕСЛИ С=0 ТО V=C+X4+5
;-----Вызов подпрограммы---— 
rcall pprog1 
;----Сравнение экспонент и мантис----— 
.def Nm=r18 
ldi Nm,0 
cp Cexp,Nexp 
cp Cm,Nm 
brsh m1;c=>n 
cp Cexp,Nexp 
cp Cm,Nm 
brlo m2;c<n 
rjmp exit 
;------Задание подпрогрммы для условия 1 и условия 2------— 
usl1: 
rcall m1 
rjmp exit 
usl2: 
rcall m2 
rjmp exit 
exit: 
nop 
;-------Вызов подпрогшраммы pprog 1-----— 
pprog1: 
cp x1exp,x2exp 
brne exit 
cp x1exp,x3exp 
brne exit 
;-----Арифметические действия----— 
add x1m,x2m;x1=x1+x2 
add x1m,x3m;x1=x1+x3 
mov Cm,x1m;Cm=x1m 
mov Cexp,x1exp;Cexp=x1exp 
ret 
;-----Вызов метки m1-------— 
m1: 
cp Cexp,x4exp 
brne exit 
cp x4exp,x5exp 
brne exit 
;---------Арифметические действия--------— 
sub Cexp,x4exp;C=c-x4 
sub Cexp,x5exp;c=c-x5 
mov Vm,Cm;Vm=Cm 
mov Vexp,Cexp ;Vexp=Cexp 
ret 
;----------Вызов метки m2-------— 
m2: 
cp x4exp,x5exp 
brne exit 
cp Cexp,x4exp 
brne exit 
;------Арифметические действия-------— 
add x4exp,x5exp;x4=x4+x5 
sub Cexp,x4exp ;C=c-x4 
mov Vm,Cm;Vm=Cm 
mov Vexp,Cexp ;Vexp=Cexp 
ret
