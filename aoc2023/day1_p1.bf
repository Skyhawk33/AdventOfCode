>0   0v0              <       ;1. initialize X/Y with 0. clear the stack ;
 vp70:<_v#!g70<               ;4. store the first digit in X             ;
 v      < v $_^#`*28:<        ;3. only keep digits ( c < 'A', Y = c )    ;
 >17p     >#v~86*-:0`|        ;2. read in a character ( c > '\n' )       ;
     vg70g71<       $<        ;                                          ;
     > :!#v_25**+:.+  ^       ;5. Stk[0]=10X+Y+Stk[0] (:. debug)         ;
          >25*, $$. 25*,@     ;6. print Stk[0] (\n's for debug)          ;
XY                            ;0. this solution requires there are no 0's;

