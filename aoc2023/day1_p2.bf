>0   0v0              <       ;1. initialize X/Y with 0. clear the stack     ;
 vp70:<_v#!g70<               ;4. store the first digit in X                 ;
 > v    <v*68_^#`*28:<        ;3. only keep digits ( c < 'A', Y = c )        ;
v  >:17p>  #v~86*-:0`|        ;2. read in a character ( c > '\n' )           ;
|           <       $<        ;                                              ;
>17g07g:!#v_25**+:.++ ^       ;5. Stk[0]=10X+Y+Stk[0] (:. debug)             ;
        # >25*, $$. 25*,@     ;6. print Stk[0] (\n's for debug)              ;
XYAB    $#                    ;0. this solution requires there are no 0's    ;
ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
>27p8g:v#> +027p 008p >:27g1+:27p8pv   ;3.1. save the stack to Z/A in reverse;
^:-1g72_^             ^            _v    ;3.2. fill the stack with a word    ;
>    01^                v3 "one"  01<      ;3.3. compare the stack with Z    ;
                        v3 "two"  02 $<      ;3.4. If they match, store X/Y  ;
                        v5 "three"03   $<      ;3.5 reload the stack         ;
                        v4 "four" 04     $<              
                        v4 "five" 05       $<                            
                        v3 "six"  06         $<                          
                        v5 "seven"07           $<                        
                        v5 "eight"08             $<                      
^      p71<<     vp73+1 <4 "nine" 09v#             $<              
      >   ^|g70$_v#!:          _    |>|>|>|>|>|>|>|>|            
      ^p70:<     >37g1-:37p8g-!^    1!1!1!1!1!1!1!1!            
                                    -:-:-:-:-:-:-:-:                
                                    >^>^>^>^>^>^>^>^                    
^                                                  $<  