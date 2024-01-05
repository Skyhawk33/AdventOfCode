
#Befunge 98 Cheatsheet

###Links
[EsoLang](https://esolangs.org/wiki/Funge-98)

[ASCII table](https://ss64.com/ascii.html)

[PyFunge](https://pythonhosted.org/PyFunge/index.html)

[Online B93 Debugger](https://esolangpark.vercel.app/ide/befunge93)

##Befunge93
*Funge-space is only 8-bit

**EOF input acts as 0

 | ASCII | Instruction          | Before       | After     
 |-------|----------------------|--------------|---------- 
 | + - * / % | Math             | a b          | a+b       
 | < > ^ v ? # | Move           |              |           
 | ! `   | logic                | a \[b]       |           
 | _ ┃   | If                   | b            |   
 | " : \ $ 0-9 | stack ops      |              |           
 | & .   | Int I/O              |              |           
 | ~ ,   | Char I/O             |              |          
 | g p   | funge-space I/O      |              |   
 | @     | Halt                 |              |           



##Execution
 | ASCII | Instruction          | Before       | After     | Other Effects
 |-------|----------------------|--------------|---------- | -------------------------------
 | @     | Stop                 |              |           | halt IP
 | q     | Quit/98              | r            |           | immediate exit, returncode = r
 | k     | Iterate/98           | n            |           | execute next instruction now, n times
 | (     | Load Semantics/98    | en..e1 n     | f 1       | overloads A-Z
 | )     | Unload Semantics/98  | en..e1 n     |           | unloads last A-Z
 | A-Z   |                      |              |           | Fingerprint-Defined/98
 | =     | Execute/98/f         | STR          | r         | r = system-execute(STR)
 | y     | Get SysInfo/98       | c            | en(..e1)  | if c>20, acts as 'pick' on stack
 | z     | No Operation/98      |              |           |


##Movement
 | ASCII | Instruction          | Before       | After     | Other Effects
 |-------|----------------------|--------------|---------- | -------------------------------
 | < > ^ v  | Direction            |              |           | delta <- (+-1, +-1)
 | #     | Trampoline           |              |           | pos <- pos + delta
 | _ ┃   | If Branch            | b            |           | delta <- if (b) (-1,0) else (1,0)
 | r     | Reflect/98           |              |           | delta <- delta * -1
 | ;     | Jump Over/98         |              |           | nothing executed until next ;
 | ?     | Go Away              |              |           | delta <- (1,0)?(-1,0)?(0,1)?(0,-1)
 | j     | Jump Forward/98      | s            |           | pos <- pos + delta * s
 | [ ]   | Turn Left/Right      |              |           | delta <- rot(+-90, delta)
 | w     | Compare/98/2D        | a b          |           | if (a>b) ']' elsif (a<b) '[' else 'z'
 | x     | Absolute Delta/98    | Va           |           | delta <- Va
 
##Input/Output
*EOF input reflects

 | ASCII | Instruction          | Before       | After     | Other Effects
 |-------|----------------------|--------------|---------- | -------------------------------
 | &     | Input Integer        |              | a         | a = readint()
 | .     | Output Integer       | a            |           | writeint(a)
 | ~     | Input Character      |              | c         | c = readchar()
 | ,     | Output Character     | c            |           | writechar(c)
 | '     | Fetch Character/98   |              | c         | pos <- pos + delta
 | s     | Store Character/98   | c            |           | store-funge-space(position+delta,v)
 | g     | Get                  | Va           | v         | v = fetch-funge-space(offset+Va)
 | p     | Put                  | v Va         |           | store-funge-space(offset+Va,v)
 | i     | Input File/98/f      | Va f STR     | Va Vb     | inputs file
 | o     | Output File/98/f     | Va Vb f STR  |           | outputs file

##Stack
 | ASCII | Instruction          | Before       | After     | Other Effects
 |-------|----------------------|--------------|---------- | -------------------------------
 | "     | Toggle Stringmode    |              |           | stringmode <- NOT stringmode
 | 0-9 a-f | Push Hexadecimal   |              | n         |
 | :     | Duplicate            | v            | v v       |
 | $     | Pop                  | n            |           |
 | \     | Swap                 | a b          | b a       |
 | n     | Clear Stack/98       | en..e1       |           |
 | u     | Stack Under Stack/98 | n            | (en..e1)  |
 | {     | Begin Block/98       | en..e1 n     | (en..e1)  | offset <- pos + delta, etc
 | }     | End Block/98         | en..e1 n     | (en..e1)  | offset <- SOSS Va, etc


##Boolean
 | ASCII | Instruction          | Before       | After     | Other Effects
 |-------|----------------------|--------------|---------- | -------------------------------
 | !     | Logical Not          | b            | NOT b     |
 | `     | Greater Than         | a b          | a > b     | either 1 or 0


##Math
 | ASCII | Instruction          | Before       | After     | Other Effects
 |-------|----------------------|--------------|---------- | -------------------------------
 | %     | Remainder            | a b          | a REM b   |
 | *     | Multiply             | a b          | a * b     |
 | +     | Add                  | a b          | a + b     |
 | -     | Subtract             | a b          | a - b     |
 | /     | Divide               | a b          | a / b     |
 
##Concurrent
 | ASCII | Instruction          | Before       | After     | Other Effects
 |-------|----------------------|--------------|---------- | -------------------------------
 | t     | Split/98/c           |              |           | Split IP


##Trefunge
*Use \f to separate Trefunge planes

 | ASCII | Instruction          | Before       | After     | Other Effects
 |-------|----------------------|--------------|---------- | -------------------------------
 | h     | Go High/98/3D        |              |           | delta <- (0,0,-1)
 | l     | Go Low/98/3D         |              |           | delta <- (0,0,1)
 | m     | High-Low If/98/3D    | b            |           | delta <- if (b) (0,0,-1) else (0,0,1)
